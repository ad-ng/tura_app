import 'package:flutter/material.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

TextEditingController _searchController = TextEditingController();

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          myappbar(screenHeight: screenHeight),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(
            'How can we help you ?',
            style: TextStyle(
                fontSize: 25, color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: screenHeight * 0.009,
          ),
          Container(
            height: 55,
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Center(
              child: TextFormField(
                controller: _searchController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.grey[400],
                    filled: true,
                    prefixIcon: Icon(Icons.search_rounded),
                    prefixIconColor: Theme.of(context).colorScheme.secondary,
                    hintText: 'Search',
                    suffix: IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: Icon(Icons.close_rounded))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
