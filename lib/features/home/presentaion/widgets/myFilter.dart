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

  String dropDownValuePrice = '[0,10000000000]'; // Default value is 'All'

  bool isForSale = false;
  bool isLand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Mysearch(textEditingController: textEditingController),

        // Updated MyFilterRow to use dynamic dropDownValue
        MyFilterRow(
          dropDownTitle: 'Price:      ',
          firstDropDown:
              dropDownValuePrice, // Use the dynamic dropDownValue here
          itemRanges: priceRanges,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValuePrice = newValue!;
            });
          },
        ),

        // Optionally uncomment the other filter rows if you need them:
        // MyFilterRow(
        //   dropDownTitle: 'Size:         ',
        //   firstDropDown: 'All',
        //   itemRanges: priceRanges,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue = newValue;
        //     });
        //   },
        // ),
        // MyFilterRow(
        //   dropDownTitle: 'Category:',
        //   firstDropDown: 'All',
        //   itemRanges: priceRanges,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue = newValue;
        //     });
        //   },
        // ),
        // MyFilterRow(
        //   dropDownTitle: 'Location:',
        //   firstDropDown: 'All',
        //   itemRanges: priceRanges,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue = newValue;
        //     });
        //   },
        // ),

        // Add checkbox filters for `For Sale` and `Land` (if needed)
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

        // Buttons for "Cancel" and "Search"
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
                // Call filterProperties method in Cubit with all selected filters
                BlocProvider.of<PropertiesCubit>(context)
                    .filterProperties(isForSale, dropDownValuePrice);
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
