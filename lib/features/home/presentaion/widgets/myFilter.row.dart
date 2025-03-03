import 'package:flutter/material.dart';

class MyFilterRow extends StatefulWidget {
  final String dropDownTitle;

  final String firstDropDown;
  final itemRanges;
  final onChanged;

  const MyFilterRow({
    super.key,
    required this.dropDownTitle,
    required this.firstDropDown,
    required this.itemRanges,
    required this.onChanged,
  });

  @override
  State<MyFilterRow> createState() => _MyFilterRowState();
}

class _MyFilterRowState extends State<MyFilterRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        Text(
          widget.dropDownTitle,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.surface),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        DropdownButton<String>(
          items: widget.itemRanges,
          value: widget.firstDropDown, // Use the valid dropDownValue here
          onChanged: widget.onChanged,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.04)
      ],
    );
  }
}
