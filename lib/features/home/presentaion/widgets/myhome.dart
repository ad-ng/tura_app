import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/presentaion/cubit/propertiesCubit.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';
import 'package:tura_app/features/home/presentaion/widgets/propertyCard.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late ScrollController _scrollController;
  List properties = [];
  int page = 2;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    // Fetch initial data when the widget is first created
    _fetchInitialData();
  }

  void _fetchInitialData() {
    BlocProvider.of<PropertiesCubit>(context).fetchProps(page);
    page++; // Increment page after the initial fetch
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        hasMore) {
      BlocProvider.of<PropertiesCubit>(context).fetchProps(page);
      page++;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.01),
        myappbar(screenHeight: screenHeight),
        SizedBox(height: screenHeight * 0.00001),
        BlocListener<PropertiesCubit, PropertiesState>(
          listener: (context, state) {
            if (state is PropertiesSuccess) {
              if (state.response.isEmpty) {
                setState(() {
                  hasMore = false;
                });
              } else {
                setState(() {
                  properties.addAll(state.response);
                });
              }
            } else if (state is PropertiesError) {
              // Optionally show an error using a Snackbar or dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: BlocBuilder<PropertiesCubit, PropertiesState>(
            builder: (context, state) {
              if (state is PropertiesLoading && properties.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      properties.length + (state is PropertiesLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= properties.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final property = properties[index];

                    return Propertycard(
                      key: Key(property.id.toString()), // Unique key
                      property: property,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
