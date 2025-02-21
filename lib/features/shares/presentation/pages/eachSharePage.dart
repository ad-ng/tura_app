import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/graphview.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';
import 'package:tura_app/features/shares/presentation/bloc/wholeShareTree.dart';

class GraphExample extends StatelessWidget {
  static const _defaultNodeWidth = 80.0; // Reduced for smaller screens
  static const _defaultNodeHeight = 40.0; // Reduced for smaller screens

  final BuchheimWalkerConfiguration configuration =
      BuchheimWalkerConfiguration()
        ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM
        ..siblingSeparation = 20 // Reduced for compactness
        ..levelSeparation = 40 // Reduced for compactness
        ..subtreeSeparation = 30; // Reduced for compactness

  GraphExample({super.key});

  Graph _buildGraphFromResponse(dynamic responseData) {
    final graph = Graph();
    final rootNode = Node.Id("Referral Tree Root");
    graph.addNode(rootNode);

    if (responseData == null) {
      debugPrint('Response data is null');
      return graph;
    }

    try {
      if (responseData is List<dynamic>) {
        final rootShares = responseData
            .where(
                (share) => share is Sharemodel && share.parentShareId == null)
            .cast<Sharemodel>()
            .toList();
        debugPrint('Found ${rootShares.length} root shares');
        if (rootShares.isEmpty) {
          debugPrint('No root shares found');
          return graph;
        }
        final Map<String, Node> senderNodes = {};
        for (final rootShare in rootShares) {
          _addPersonNodes(rootShare, rootNode, graph, senderNodes);
        }
      } else if (responseData is Sharemodel) {
        if (responseData.parentShareId == null) {
          final Map<String, Node> senderNodes = {};
          _addPersonNodes(responseData, rootNode, graph, senderNodes);
        }
      } else {
        debugPrint('Unexpected responseData type: ${responseData.runtimeType}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error building graph: $e\nStack trace: $stackTrace');
    }

    debugPrint(
        'Graph built with ${graph.nodes.length} nodes and ${graph.edges.length} edges');
    debugPrint('Nodes: ${graph.nodes.map((n) => n.key?.value).toList()}');
    return graph;
  }

  void _addPersonNodes(Sharemodel share, Node parent, Graph graph,
      Map<String, Node> senderNodes) {
    try {
      final senderUsername =
          share.sender?.username ?? 'User_${share.senderId ?? share.id}';
      final senderKey = share.senderId?.toString() ?? share.id.toString();
      final senderNodeId = 'Sender_$senderUsername';

      Node senderNode;
      if (senderNodes.containsKey(senderKey)) {
        senderNode = senderNodes[senderKey]!;
      } else {
        senderNode = Node.Id(senderNodeId);
        senderNodes[senderKey] = senderNode;
        graph.addEdge(parent, senderNode, paint: Paint()..color = Colors.grey);
      }

      if (share.sender?.username == null) {
        debugPrint(
            'Sender username null for share ID ${share.id}, using $senderUsername');
      }

      final children = share.children ?? [];
      if (children.isEmpty) {
        final recipientUsername = share.recipient?.username ??
            'User_${share.recipientId ?? share.id}';
        final recipientNodeId = 'Recipient_${share.id}_$recipientUsername';
        final recipientNode = Node.Id(recipientNodeId);
        graph.addEdge(senderNode, recipientNode,
            paint: Paint()..color = Colors.grey);

        if (share.recipient?.username == null) {
          debugPrint(
              'Recipient username null for share ID ${share.id}, using $recipientUsername');
        }
      } else {
        for (final child in children) {
          if (child is Sharemodel) {
            _addPersonNodes(child, senderNode, graph, senderNodes);
          } else {
            debugPrint('Invalid child type: ${child.runtimeType}');
          }
        }
      }
    } catch (e) {
      debugPrint('Error adding node for share ID ${share.id}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a TransformationController to set initial scale
    final TransformationController controller = TransformationController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Tree'),
        elevation: 2,
      ),
      body: BlocBuilder<Wholesharetree, WholesharetreeState>(
        builder: (context, state) {
          return switch (state) {
            WholesharetreeLoading() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            WholesharetreeError(:final message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${message ?? 'Unknown error'}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        //    context.read<Wholesharetree>().add(FetchShareTree());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            WholesharetreeSuccess(:final response) => Builder(
                builder: (context) {
                  try {
                    final graph = _buildGraphFromResponse(response);
                    if (graph.nodes.length <= 1) {
                      return const Center(
                          child: Text('No referral data to display'));
                    }
                    debugPrint(
                        'Attempting to render graph with ${graph.nodes.length} nodes');

                    // Estimate graph size (rough approximation)
                    final nodeCount = graph.nodes.length;
                    final initialScale =
                        _calculateInitialScale(nodeCount, context);
                    controller.value = Matrix4.identity()..scale(initialScale);

                    return Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - 100,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: InteractiveViewer(
                        transformationController: controller,
                        constrained: false,
                        boundaryMargin: const EdgeInsets.all(50),
                        minScale: 0.1, // Allow zooming out to see everything
                        maxScale: 3.0, // Increased for detailed zoom
                        child: GraphView(
                          graph: graph,
                          algorithm: BuchheimWalkerAlgorithm(
                            configuration,
                            TreeEdgeRenderer(configuration),
                          ),
                          paint: Paint()
                            ..color = Colors.grey
                            ..strokeWidth = 1
                            ..style = PaintingStyle.stroke,
                          builder: (Node node) => _buildNodeWidget(node),
                        ),
                      ),
                    );
                  } catch (e, stackTrace) {
                    debugPrint('Rendering error: $e\nStack trace: $stackTrace');
                    return Center(child: Text('Rendering error: $e'));
                  }
                },
              ),
            _ => const Center(child: Text('Unknown state')),
          };
        },
      ),
    );
  }

  // Calculate initial scale based on node count and screen size
  double _calculateInitialScale(int nodeCount, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - 100; // Account for app bar
    // Rough estimate: assume graph width/height grows with sqrt(nodeCount)
    final estimatedGraphSize =
        nodeCount * 20.0; // Adjust multiplier based on your graph
    final scaleX = screenWidth / estimatedGraphSize;
    final scaleY = screenHeight / estimatedGraphSize;
    final scale = scaleX < scaleY ? scaleX : scaleY; // Fit to smaller dimension
    return scale.clamp(0.1, 1.0); // Ensure it’s within reasonable bounds
  }

  Widget _buildNodeWidget(Node node) {
    final key = node.key?.value.toString() ?? 'Unknown';
    final parts = key.split('_');
    final displayText = parts.last;
    final isRecipient = key.contains('Recipient');
    return Container(
      width: _defaultNodeWidth,
      height: _defaultNodeHeight,
      decoration: BoxDecoration(
        color: isRecipient ? Colors.blue[100] : Colors.green[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1, // Reduced for smaller nodes
            blurRadius: 3, // Reduced for smaller nodes
          ),
        ],
      ),
      padding: const EdgeInsets.all(6), // Reduced padding
      child: Center(
        child: Text(
          displayText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12, // Reduced for smaller nodes
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
