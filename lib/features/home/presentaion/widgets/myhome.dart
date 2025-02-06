import 'package:flutter/material.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';

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
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  height: screenHeight * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                          'https://d1covwzj3ggua9.cloudfront.net/property/3b7ae8e7442fb24b6daad61a.jpeg'),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Cozzy Studio',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            Text(
                              'Near the golf field',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.photo_size_select_small),
                                Text('80 m'),
                              ],
                            ),
                            Row(
                              children: [Icon(Icons.bed), Text('bedrooms')],
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.bathtub_sharp),
                              Text('2 bathrooms'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.car_rental_sharp),
                              Text('bedrooms')
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]);
            },
          ))
        ],
      ),
    );
  }
}
