import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/presentaion/pages/singleproperty.dart';
import 'package:tura_app/features/shares/presentation/bloc/sharesSentCubit.dart';
import 'package:tura_app/features/shares/presentation/bloc/wholeShareTree.dart';
import 'package:tura_app/features/shares/presentation/pages/eachSharePage.dart';

class Sharessent extends StatefulWidget {
  const Sharessent({super.key});

  @override
  State<Sharessent> createState() => _SharessentState();
}

class _SharessentState extends State<Sharessent> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<SharesSentCubit, SharesSentState>(
      builder: (context, state) {
        if (state is SharesSentLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is SharesSentError) {
          return Center(
            child: Text('${state.message.toString()}'),
          );
        }
        if (state is SharesSentSuccess) {
          // Using a set to track unique slugs
          Set<String> seenSlugs = Set();
          // Filter out the properties that have already been added to the set
          var uniqueProperties = state.response.where((property) {
            // If the slug has already been seen, return false to filter it out
            if (seenSlugs.contains(property.property.slug!)) {
              return false;
            } else {
              // Add the slug to the set for future checks
              seenSlugs.add(property.property.slug!);
              return true;
            }
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Property',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Referrer',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Info',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Theme.of(context).colorScheme.secondary,
                width: screenWidth,
                height: 1,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: uniqueProperties.length,
                  itemBuilder: (context, index) {
                    var property = uniqueProperties[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Singleproperty(
                                          slug: property.property.slug!,
                                          propertyId: property.propertyId,
                                        ),
                                      ),
                                    ),
                                    child: Image.network(
                                      '${property.property.imageUrls![0]}',
                                      width: screenWidth * 0.15,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      property.sender!.profileImg!,
                                      width: screenWidth * 0.1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog.adaptive(
                                            title: Text('Quick share info'),
                                            content: Container(
                                              height: 20,
                                              child: Text(
                                                  'shares sent to ${state.response.length} people'),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  Wholesharetree>(
                                                              context)
                                                          .fetchShareTree(
                                                              property.id);

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EachSharePage(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text('whole tree'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('cancel'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
