import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/presentaion/pages/singleproperty.dart';
import 'package:tura_app/features/shares/presentation/bloc/sharesRecievedCubit.dart';
import 'package:tura_app/features/shares/presentation/bloc/wholeShareTree.dart';
import 'package:tura_app/features/shares/presentation/pages/eachSharePage.dart';

class Sharesrecieved extends StatefulWidget {
  const Sharesrecieved({super.key});

  @override
  State<Sharesrecieved> createState() => _SharesrecievedState();
}

class _SharesrecievedState extends State<Sharesrecieved> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<SharesrecievedCubit, SharesRecievedState>(
      builder: (context, state) {
        if (state is SharesRecievedLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is SharesRecievedError) {
          return Center(
            child: Text('${state.message}'),
          );
        }
        if (state is SharesRecievedSuccess) {
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
                      'Sender',
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<Wholesharetree>(context)
                                            .fetchShareTree(property.id);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EachSharePage(),
                                          ),
                                        );
                                      },
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
        return Center(
          child: Text('error'),
        );
      },
    );
  }
}
