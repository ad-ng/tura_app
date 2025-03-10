import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/graphview.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';
import 'package:tura_app/features/shares/presentation/bloc/wholeShareTree.dart';

class EachSharePage extends StatefulWidget {
  const EachSharePage({super.key});

  @override
  State<EachSharePage> createState() => _EachSharePageState();
}

class _EachSharePageState extends State<EachSharePage> {
  static const _defaultNodeWidth = 80.0;
  static const _defaultNodeHeight = 30.0;

  final BuchheimWalkerConfiguration configuration =
      BuchheimWalkerConfiguration()
        ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM
        ..siblingSeparation = 10
        ..levelSeparation = 40
        ..subtreeSeparation = 20;

  late Map<String, bool> _expandedNodes;
  late List<Sharemodel> _rootShares;
  late Graph _graph; // Declared as a class-level field

  @override
  void initState() {
    super.initState();
    _expandedNodes = {};
    _rootShares = [];
    _graph = Graph(); // Initialize with an empty graph
  }

  Graph _buildGraphFromResponse(dynamic responseData) {
    final graph = Graph();
    final rootNode = Node.Id("start");
    graph.addNode(rootNode);
    _expandedNodes['root'] = true; // Root is always expanded initially

    if (responseData == null) {
      debugPrint('Response data is null');
      return graph;
    }

    try {
      if (responseData is List<dynamic>) {
        _rootShares = responseData
            .where(
                (share) => share is Sharemodel && share.parentShareId == null)
            .cast<Sharemodel>()
            .toList();
        debugPrint('Found ${_rootShares.length} root shares');
        if (_rootShares.isEmpty) {
          debugPrint('No root shares found');
          return graph;
        }
        final Map<String, Node> senderNodes = {};
        for (final rootShare in _rootShares) {
          _addPersonNodes(rootShare, rootNode, graph, senderNodes);
        }
      } else if (responseData is Sharemodel &&
          responseData.parentShareId == null) {
        _rootShares = [responseData];
        final Map<String, Node> senderNodes = {};
        _addPersonNodes(responseData, rootNode, graph, senderNodes);
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

      final children = share.children;
      if (_expandedNodes[senderNodeId] == true) {
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
            _addPersonNodes(child, senderNode, graph, senderNodes);
          }
        }
      }
    } catch (e) {
      debugPrint('Error adding node for share ID ${share.id}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Text('Error: ${message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        //  context.read<Wholesharetree>().add(FetchShareTree());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            WholesharetreeSuccess(:final response) => Builder(
                builder: (context) {
                  try {
                    _graph = _buildGraphFromResponse(
                        response); // Update class-level _graph
                    if (_graph.nodes.length <= 1) {
                      return const Center(
                          child: Text('No referral data to display'));
                    }
                    debugPrint(
                        'Attempting to render graph with ${_graph.nodes.length} nodes');

                    final nodeCount = _graph.nodes.length;
                    final initialScale =
                        _calculateInitialScale(nodeCount, context);
                    controller.value = Matrix4.identity()..scale(initialScale);

                    return InteractiveViewer(
                      transformationController: controller,
                      constrained: false,
                      boundaryMargin: const EdgeInsets.all(50),
                      minScale: 0.1,
                      maxScale: 3.0,
                      child: GraphView(
                        graph: _graph,
                        algorithm: BuchheimWalkerAlgorithm(
                            configuration, TreeEdgeRenderer(configuration)),
                        paint: Paint()
                          ..color = Colors.grey
                          ..strokeWidth = 1
                          ..style = PaintingStyle.stroke,
                        builder: (Node node) => _buildNodeWidget(
                            node, state.response[0].property.imageUrls![0]),
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

  double _calculateInitialScale(int nodeCount, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height - 100;
    final estimatedGraphSize = nodeCount * 20.0;
    final scaleX = screenWidth / estimatedGraphSize;
    final scaleY = screenHeight / estimatedGraphSize;
    final scale = scaleX < scaleY ? scaleX : scaleY;
    return scale.clamp(0.1, 1.0);
  }

  Widget _buildNodeWidget(Node node, String imgUrl) {
    final key = node.key?.value.toString() ?? 'Unknown';

    // Handle root node with network image
    if (key == 'start') {
      return Container(
        width: 50, // Circle diameter
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imgUrl), // Replace with your image URL
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.blue, width: 2),
        ),
      );
    }

    // Existing code for other nodes
    final parts = key.split('_');
    final displayText = parts.last;
    final isRecipient = key.contains('Recipient');

    return GestureDetector(
      onTap: () {
        if (!isRecipient) {
          setState(() {
            _expandedNodes[key] = !(_expandedNodes[key] ?? false);
            _graph = _buildGraphFromResponse(_rootShares);
          });
        }
      },
      child: Container(
        width: _defaultNodeWidth,
        height: _defaultNodeHeight,
        decoration: BoxDecoration(
          color: isRecipient ? Colors.blue[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: Center(
          child: Text(
            displayText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
