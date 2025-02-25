import 'package:flutter/material.dart';

Widget eachQuestionTile(
    {required String question,
    required String answer,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconColor: Colors.black,
        collapsedIconColor: Theme.of(context).colorScheme.secondary,
        childrenPadding: EdgeInsets.only(left: 16, bottom: 16),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        collapsedTextColor: Theme.of(context).colorScheme.secondary,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textColor: Colors.black,
        expandedAlignment: Alignment.bottomLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        children: [
          Text(
            answer,
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
