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

  // Sample hierarchical data
  final List<Map<String, dynamic>> data = [
    {
      "name": "person1",
      "children": [
        {"name": "person3", "children": []},
        {
          "name": "person4",
          "children": [
            {"name": "person5", "children": []}
          ]
        },
        {"name": "person6", "children": []}
      ]
    },
    {"name": "person2", "children": []},
    {"name": "person7", "children": []}
  ];

  // Map to store nodes by person name (for easy reference)
  final Map<String, Node> nodeMap = {};

  void buildGraph() {
    // Create a root node
    Node rootNode = Node.Id("root");
    graph.addNode(rootNode);

    // Traverse the data and create the graph, connecting person1 to the root node
    data.forEach((person) {
      _addPersonNode(person, rootNode); // Connect the first level to root node
    });
  }

  // Recursive function to add a person and their children to the graph
  void _addPersonNode(Map<String, dynamic> personData, [Node? parent]) {
    String personName = personData['name'];

    // Create the node if it doesn't exist yet
    if (!nodeMap.containsKey(personName)) {
      Node newNode = Node.Id(personName);
      nodeMap[personName] = newNode;

      // If there is a parent, create an edge
      if (parent != null) {
        graph.addEdge(parent, newNode);
      }

      // Add children recursively
      List children = personData['children'];
      for (var child in children) {
        _addPersonNode(
            child, newNode); // Connect the child to the current person
      }
    }
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
                        child: Center(child: Text(node.key!.value.toString())),
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
