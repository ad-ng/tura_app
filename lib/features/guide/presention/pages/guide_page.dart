import 'package:flutter/material.dart';
import 'package:tura_app/features/guide/data/datasource/faqApiService.dart';
import 'package:tura_app/features/guide/data/model/faqModel.dart';
import 'package:tura_app/features/guide/presention/widgets/eachQuestionTile.dart';
import 'package:tura_app/features/guide/presention/widgets/faqCategory.dart';
import 'package:tura_app/features/guide/presention/widgets/mySearch.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  late List<FaqModel> faqs = []; // Original unfiltered FAQ list
  late List<FaqModel> filteredFaqs = []; // Filtered list for display
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list with all FAQs
    filteredFaqs = faqs;

    // Add a listener to searchController to listen for text changes
    _searchController.addListener(() {
      
      filterFAQs(
          _searchController.text); // Filter whenever the search text changes
    });
  }

  void filterFAQs(String query) {
    // If the query is empty, show all FAQs
    if (query.isEmpty) {
      setState(() {
        filteredFaqs = faqs; // Show all FAQs when search is cleared
      });
    } else {
      setState(() {
        filteredFaqs = faqs
            .where((faq) =>
                faq.question.toLowerCase().contains(query.toLowerCase()) ||
                faq.answer.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Filter by Account category
                          filteredFaqs = faqs
                              .where((faq) => faq.subject == 'Account')
                              .toList();
                        });
                      },
                      child: faqCategory(
                        context: context,
                        faqCategoryName: 'Account',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Filter by Shares category
                          filteredFaqs = faqs
                              .where((faq) => faq.subject == 'Share')
                              .toList();
                        });
                      },
                      child: faqCategory(
                        context: context,
                        faqCategoryName: 'Shares',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Filter by Property category
                          filteredFaqs = faqs
                              .where((faq) => faq.subject == 'Property')
                              .toList();
                        });
                      },
                      child: faqCategory(
                        context: context,
                        faqCategoryName: 'Property',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder<List<FaqModel>>(
            future: FaqApiService().fetchFaq(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  faqs = snapshot.data!;

                  // If the filtered list is empty (first time), set the filtered list to all FAQs
                  if (filteredFaqs.isEmpty) {
                    filteredFaqs = faqs;
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredFaqs.length,
                      itemBuilder: (context, index) {
                        return eachQuestionTile(
                            question: filteredFaqs[index].question,
                            answer: filteredFaqs[index].answer,
                            context: context);
                      },
                    ),
                  );
                } else {
                  return Center(child: Text("No data available"));
                }
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
