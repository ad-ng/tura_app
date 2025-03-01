import 'package:flutter/material.dart';

Widget faqCategory({
  required BuildContext context,
  required String faqCategoryName,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).colorScheme.secondary,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Center(
        //   child: Icon(
        //     Icons.lightbulb_sharp,
        //     color: Colors.yellow[900],
        //     size: 35,
        //   ),
        // ),
        Text(
          'Questions \nabout:',
          style: TextStyle(color: Colors.grey[800]),
        ),
        Text(
          faqCategoryName,
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
