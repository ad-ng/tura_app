import 'package:flutter/material.dart';

Widget faqCategory(
    {required BuildContext context,
    required String faqCategoryName,
    required faqIcon,
    required double iconSize}) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    height: 200,
    width: 130,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).colorScheme.secondary,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Icon(
            faqIcon,
            size: iconSize,
          ),
        ),
        Text(
          'Questions about:',
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
