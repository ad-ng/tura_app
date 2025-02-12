import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/shares/presentation/bloc/sharesSentCubit.dart';

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
                      'Referrer',
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
        return SizedBox.shrink();
      },
    );
  }
}
