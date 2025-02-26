import 'package:flutter/material.dart';
import 'package:tura_app/features/guide/data/datasource/faqApiService.dart';
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
            height: 145,
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
          FutureBuilder(
            future: FaqApiService().fetchFaq(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("error ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return eachQuestionTile(
                          question: snapshot.data![index].question,
                          answer: snapshot.data![index].answer,
                          context: context);
                    },
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
