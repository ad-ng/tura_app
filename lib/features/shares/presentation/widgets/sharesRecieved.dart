import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/shares/presentation/bloc/sharesRecievedCubit.dart';

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
            child: Text('${e.toString()}'),
          );
        }
        if (state is SharesRecievedSuccess) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID',
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
                      'Property',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
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
                  itemCount: state.response.length,
                  itemBuilder: (context, index) {
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
                                  Text(
                                    '${state.response[index].id}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 18,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      state.response[index].sender!.profileImg!,
                                      width: screenWidth * 0.1,
                                    ),
                                  ),
                                  Image.network(
                                    '${state.response[index].property.imageUrls![0]}',
                                    width: screenWidth * 0.15,
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
