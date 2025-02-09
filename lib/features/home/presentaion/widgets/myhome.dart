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
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.01,
          ),
          myappbar(screenHeight: screenHeight),
          SizedBox(
            height: screenHeight * 0.00001,
          ),
          // FutureBuilder<List<PropertiesModel>>(
          //   //future: _propertiesApiService.fetchProps(),
          //   future: _propertiesApiService.fetchProps(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError) {
          //       // Handle errors
          //       return Center(child: Text('Error: ${snapshot.error}'));
          //     } else {
          //       return Expanded(
          //         child: ListView.builder(
          //           itemCount: snapshot.data!.length,
          //           itemBuilder: (context, index) {
          //             final property = snapshot.data![index];
          //             return Propertycard(property: property);
          //           },
          //         ),
          //       );
          //     }
          //   },
          // ),
          BlocBuilder<PropertiesCubit, PropertiesState>(
            builder: (context, state) {
              if (state is PropertiesLoading) {
                print('Loading properties...');
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state is PropertiesSuccess) {
                print('Properties loaded successfully!');
                final properties = state.response;
                return Expanded(
                  child: ListView.builder(
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      return Propertycard(property: property);
                    },
                  ),
                );
              }
              if (state is PropertiesError) {
                print('Error: ${state.message}');
                return Center(child: Text('Error: ${state.message}'));
              }
              return SizedBox.shrink(); // Default case (initial state, etc.)
            },
          )
        ],
      ),
    );
  }
}
