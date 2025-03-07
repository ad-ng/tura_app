import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/guide/presention/widgets/mySearch.dart';
import 'package:tura_app/features/home/presentaion/cubit/propertiesCubit.dart';
import 'package:tura_app/features/home/presentaion/widgets/myFilter.row.dart';

class MyFilter extends StatefulWidget {
  const MyFilter({super.key});

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  TextEditingController textEditingController = TextEditingController();

  final priceRanges = [
    DropdownMenuItem(
      value: '[0,10000000000]',
      child: Text('All'),
    ),
    DropdownMenuItem(
      value: '[0,50000000]',
      child: Text('Under RWF 50 M'),
    ),
    DropdownMenuItem(
      value: '[50000000,100000000]',
      child: Text('RWF 50 M - 100 M'),
    ),
    DropdownMenuItem(
      value: '[100000000,150000000]',
      child: Text('RWF 100 M - 150 M'),
    ),
    DropdownMenuItem(
      value: '[150000000,200000000]',
      child: Text('RWF 150 M - 200 M'),
    )
  ];

  final sizeRanges = [
    DropdownMenuItem(
      value: '[0,1000]',
      child: Text('All'),
    ),
    DropdownMenuItem(
      value: '[0,50]',
      child: Text('Under 50 m²'),
    ),
    DropdownMenuItem(
      value: '[50,100]',
      child: Text('50 m² - 100 m²'),
    ),
    DropdownMenuItem(
      value: '[100,150]',
      child: Text('100 m² - 150 m²'),
    ),
    DropdownMenuItem(
      value: '[150,200]',
      child: Text('150 m² - 200 m²'),
    )
  ];

  String dropDownValuePrice = '[0,10000000000]'; // Default value is 'All'
  String dropDownValueSize = '[0,1000]'; // Default value is 'All'

  bool isForSale = true;
  bool isForRent = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Mysearch(textEditingController: textEditingController),
        MyFilterRow(
          dropDownTitle: 'Price:      ',
          firstDropDown: dropDownValuePrice,
          itemRanges: priceRanges,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValuePrice = newValue!;
            });
          },
        ),
        MyFilterRow(
          dropDownTitle: 'Size:       ',
          firstDropDown: dropDownValueSize,
          itemRanges: sizeRanges,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValueSize = newValue!;
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
                  value: isForRent,
                  onChanged: (value) {
                    setState(() {
                      isForRent = value!;
                    });
                  },
                ),
                Text(
                  'For Rent',
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
                Navigator.pop(context); // Cancel action
              },
              child: Text('Cancel'),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<PropertiesCubit>(context).filterProperties(
                    isForSale,
                    dropDownValuePrice,
                    dropDownValueSize,
                    isForSale);
                Navigator.pop(context); // Close the filter screen
              },
              child: Text('Search'),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          ],
        ),
      ],
    );
  }
}
