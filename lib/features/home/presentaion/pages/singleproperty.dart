import 'package:flutter/material.dart';
import 'package:tura_app/features/home/data/datasources/remote/fetchAllProperties.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';

class Singleproperty extends StatelessWidget {
  final String slug;
  Singleproperty({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          slug,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
          )
        ],
      ),
      body: FutureBuilder<PropertiesModel>(
        future: FetchAllProperties().fetchSingleProp(slug),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 20),
                    child: Text(
                      snapshot.data!.title!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 35),
                    child: Text(
                      '${snapshot.data!.price} Rwf',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          snapshot.data!.place!.name!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: screenHeight * 0.32,
                    child: Image.network(snapshot.data!.imageUrls![0]),
                  ),
                  Container(
                    height: screenWidth * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.imageUrls!.length,
                      itemBuilder: (context, index) {
                        // return Image.asset(snapshot.data!.imageUrls![index]);
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Image.network(
                            snapshot.data!.imageUrls![index],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      'Description',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
