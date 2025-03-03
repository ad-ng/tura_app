import 'package:flutter/material.dart';
import 'package:tura_app/features/guide/presention/widgets/mySearch.dart';
import 'package:tura_app/features/home/presentaion/widgets/myFilter.row.dart';

class MyFilter extends StatefulWidget {
  MyFilter({super.key});

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  TextEditingController textEditingController = TextEditingController();

  final priceRanges = [
    DropdownMenuItem(
      child: Text('All'),
      value: 'All',
    ),
    DropdownMenuItem(
      child: Text('Under RWF 50 M'),
      value: 'one',
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

  String? dropDownValue = 'All'; // Set default value to 'All'

  bool isForSale = false;
  bool isLand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Mysearch(textEditingController: textEditingController),
        MyFilterRow(
          dropDownTitle: 'Property Price:      ',
          firstDropDown: 'All',
          itemRanges: priceRanges,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue;
            });
          },
        ),
        MyFilterRow(
          dropDownTitle: 'Property size:         ',
          firstDropDown: 'All',
          itemRanges: priceRanges,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue;
            });
          },
        ),
        MyFilterRow(
          dropDownTitle: 'Property Category:',
          firstDropDown: 'All',
          itemRanges: priceRanges,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue;
            });
          },
        ),
        MyFilterRow(
          dropDownTitle: 'Property Location:',
          firstDropDown: 'All',
          itemRanges: priceRanges,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Checkbox.adaptive(
                  activeColor: Colors.blueAccent,
                  value: isForSale,
                  onChanged: (value) {
                    setState(() {
                      isForSale = value!;
                    });
                  },
                ),
                Text(
                  'For Sale',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox.adaptive(
                  activeColor: Colors.blueAccent,
                  value: isLand,
                  onChanged: (value) {
                    setState(() {
                      isLand = value!;
                    });
                  },
                ),
                Text(
                  'Land',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                )
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Search'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            )
          ],
        )
      ],
    );
  }
}
