import 'package:flutter/material.dart';
import 'package:tura_app/features/guide/presention/widgets/mySearch.dart';
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
          Mysearch(textEditingController: _searchController)
        ],
      ),
    );
  }
}
