import 'package:flutter/material.dart';
import 'package:tura_app/features/home/data/datasources/remote/fetchAllProperties.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';
import 'package:tura_app/features/home/presentaion/widgets/propertyCard.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final FetchAllProperties _fetchAllProperties = FetchAllProperties();

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
          FutureBuilder<List<PropertiesModel>>(
            future: _fetchAllProperties.fetchProps(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Handle errors
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final property = snapshot.data![index];
                      return Propertycard(property: property);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
