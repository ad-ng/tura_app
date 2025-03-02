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
      child: Text('Under RWF 50 M'),
      value: '[0,50]',
    ),
    DropdownMenuItem(
      child: Text('RWF 50 M -  100 M'),
      value: 'two',
    ),
    DropdownMenuItem(
      child: Text('RWF 100 M - 150 M'),
      value: 'three',
    ),
    DropdownMenuItem(
      child: Text('RWF 150 M - 200 M'),
      value: 'four',
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
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Text(
              'Property Prices:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
