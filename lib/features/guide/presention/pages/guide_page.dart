import 'package:flutter/material.dart';
import 'package:tura_app/features/guide/presention/widgets/eachQuestionTile.dart';
import 'package:tura_app/features/guide/presention/widgets/faqCategory.dart';
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
            'Frequent Asked Questions',
            style: TextStyle(
                fontSize: 25, color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: screenHeight * 0.009,
          ),
          Mysearch(textEditingController: _searchController),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  children: [
                    faqCategory(
                        context: context,
                        faqCategoryName: 'Account',
                        faqIcon: Icons.person,
                        iconSize: 40),
                    faqCategory(
                      context: context,
                      faqCategoryName: 'Shares',
                      faqIcon: Icons.share,
                      iconSize: 35,
                    ),
                    faqCategory(
                      context: context,
                      faqCategoryName: 'Property',
                      faqIcon: Icons.house_rounded,
                      iconSize: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
          eachQuestionTile(
            question: 'what is tura',
            answer: 'is some bullshit',
            context: context,
          ),
          eachQuestionTile(
            question: 'what is tura 1',
            answer: 'is some bullshit',
            context: context,
          )
        ],
      ),
    );
  }
}
