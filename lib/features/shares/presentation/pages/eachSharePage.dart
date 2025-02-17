import 'package:flutter/material.dart';
import 'package:graphview/graphview.dart';

class GraphExample extends StatelessWidget {
  final Graph graph = Graph();
  final BuchheimWalkerConfiguration configuration =
      BuchheimWalkerConfiguration()
        ..orientation = BuchheimWalkerConfiguration.DEFAULT_ORIENTATION
        ..siblingSeparation = 20
        ..levelSeparation = 50;

  GraphExample({super.key}) {
    buildGraph();
  }

  void buildGraph() {
    final nodes = List.generate(30, (index) => Node.Id(index + 1));

    graph.addEdge(nodes[0], nodes[1]);
    graph.addEdge(nodes[0], nodes[12]);
    graph.addEdge(nodes[0], nodes[13]);
    graph.addEdge(nodes[0], nodes[14]);
    graph.addEdge(nodes[0], nodes[15]);
    graph.addEdge(nodes[0], nodes[16]);
    graph.addEdge(nodes[0], nodes[17]);
    graph.addEdge(nodes[0], nodes[18]);
    graph.addEdge(nodes[0], nodes[19]);
    graph.addEdge(nodes[0], nodes[20]);
    graph.addEdge(nodes[0], nodes[21]);
    graph.addEdge(nodes[0], nodes[22]);
    graph.addEdge(nodes[0], nodes[23]);
    graph.addEdge(nodes[0], nodes[24]);
    graph.addEdge(nodes[0], nodes[2]);
    graph.addEdge(nodes[1], nodes[3]);
    graph.addEdge(nodes[1], nodes[4]);
    graph.addEdge(nodes[2], nodes[5]);
    graph.addEdge(nodes[4], nodes[6]);
    graph.addEdge(nodes[4], nodes[7]);
    graph.addEdge(nodes[4], nodes[11]);
    graph.addEdge(nodes[5], nodes[8]);
    graph.addEdge(nodes[7], nodes[9]);
    graph.addEdge(nodes[9], nodes[10]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Working Graph Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: GraphView(
                  graph: graph,
                  algorithm: BuchheimWalkerAlgorithm(
                    configuration,
                    TreeEdgeRenderer(configuration),
                  ),
                  builder: (Node node) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 80,
                        minHeight: 40,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(child: Text('Node ${node.key!.value}')),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
