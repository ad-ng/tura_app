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
      child: Text('Under RWF 50 M             '),
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
      child: Text('Under 50 m²                    '),
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

  final categories = [
    DropdownMenuItem(
      value: '0',
      child: Text('All Types                       '),
    ),
    DropdownMenuItem(
      value: '7',
      child: Text('Commercial'),
    ),
    DropdownMenuItem(
      value: '6',
      child: Text('Land'),
    ),
    DropdownMenuItem(
      value: '5',
      child: Text('Office'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('Cottage'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Villa'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Apartment'),
    ),
    DropdownMenuItem(
      value: '1',
      child: Text('Residential House'),
    )
  ];

  String dropDownValuePrice = '[0,10000000000]';
  String dropDownValueSize = '[0,1000]';
  String dropDownValueCategories = '0'; // Default value is 'All'

  bool isForSale = true;
  bool isForRent = false;
  bool hasParking = true;

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
        MyFilterRow(
          dropDownTitle: 'Category',
          firstDropDown: dropDownValueCategories,
          itemRanges: categories,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValueCategories = newValue!;
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
                  'Sale',
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
                  'Rent',
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
                  value: hasParking,
                  onChanged: (value) {
                    setState(() {
                      hasParking = value!;
                    });
                  },
                ),
                Text(
                  'Parking',
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
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cancel action
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            TextButton(
              onPressed: () {
                BlocProvider.of<PropertiesCubit>(context).filterProperties(
                    isForSale,
                    dropDownValuePrice,
                    dropDownValueSize,
                    isForSale,
                    dropDownValueCategories,
                    textEditingController.text,
                    hasParking);
                Navigator.pop(context); // Close the filter screen
              },
              child: Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          ],
        ),
      ],
    );
  }
}
