import 'package:flutter/material.dart';
import 'package:tura_app/features/guide/presention/widgets/mySearch.dart';

class MyFilter extends StatefulWidget {
  MyFilter({super.key});

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  TextEditingController textEditingController = TextEditingController();

  final priceRanges = [
    DropdownMenuItem(
      child: Text('All Ranges'),
      value: 'All Ranges',
    ),
    DropdownMenuItem(
      child: Text('Under RWF 50,000,000'),
      value: '[0,50]',
    ),
    DropdownMenuItem(
      child: Text('RWF 50,000,000 - RWF 100,000,000'),
      value: 'two',
    )
  ];

  String? dropDownValue = 'All Ranges'; // Set default value to 'one'

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Mysearch(textEditingController: textEditingController),
        Row(
          children: [
            Text('Property Prices'),
            SizedBox(
              width: 10,
            ),
            DropdownButton<String>(
              items: priceRanges,
              value: dropDownValue, // Use the valid dropDownValue here
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValue = newValue;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
