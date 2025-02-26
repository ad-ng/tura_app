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
  late List<FaqModel> faqs = []; // Original FAQ list
  late List<FaqModel> filteredFaqs = []; // Filtered list for display
  final TextEditingController _searchController = TextEditingController();
  late Future<List<FaqModel>>
      _faqFuture; // Store the Future to prevent multiple calls

  @override
  void initState() {
    super.initState();
    _faqFuture = FaqApiService().fetchFaq(); // Initialize Future once
    filteredFaqs = faqs; // Initial state is empty
    _searchController.addListener(() {
      filterFAQs(_searchController.text);
    });
  }

  void filterFAQs(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFaqs = faqs; // Reset to all FAQs when search is empty
      } else {
        filteredFaqs = faqs
            .where((faq) =>
                faq.question.toLowerCase().contains(query.toLowerCase()) ||
                faq.answer.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          myappbar(screenHeight: screenHeight),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'Frequent Asked Questions',
            style: TextStyle(
                fontSize: 25, color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(height: screenHeight * 0.009),
          Mysearch(textEditingController: _searchController),
          const SizedBox(height: 10),
          SizedBox(
            height: 145,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  children: [
                    // Account Category
                    GestureDetector(
                      onTap: () => setState(() {
                        filteredFaqs = faqs
                            .where((faq) => faq.subject == 'Account')
                            .toList();
                      }),
                      child: faqCategory(
                        context: context,
                        faqCategoryName: 'Account',
                      ),
                    ),
                    // Shares Category (corrected subject to 'Shares')
                    GestureDetector(
                      onTap: () => setState(() {
                        filteredFaqs = faqs
                            .where((faq) => faq.subject == 'Shares')
                            .toList();
                      }),
                      child: faqCategory(
                        context: context,
                        faqCategoryName: 'Shares',
                      ),
                    ),
                    // Property Category
                    GestureDetector(
                      onTap: () => setState(() {
                        filteredFaqs = faqs
                            .where((faq) => faq.subject == 'Property')
                            .toList();
                      }),
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
            future: _faqFuture, // Use the stored Future
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                faqs = snapshot.data!;
                // Initialize filteredFaqs with all FAQs on first load
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
                        context: context,
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
        ],
      ),
    );
  }
}
