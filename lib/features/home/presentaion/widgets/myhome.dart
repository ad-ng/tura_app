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
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  height: screenHeight * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: Image.network(
                            'https://d1covwzj3ggua9.cloudfront.net/property/3b7ae8e7442fb24b6daad61a.jpeg'),
                      ),
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
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[900],
                            ),
                            Text(
                              'Near the golf field',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: screenHeight * 0.02,
                                color: Colors.grey[900],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 60, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  '././lib/images/full-size.png',
                                  height: screenHeight * 0.025,
                                  color: Colors.grey[900],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '80 m',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  '././lib/images/sleeping.png',
                                  height: screenHeight * 0.03,
                                  color: Colors.grey[900],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '2 bedrooms',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.grey[900],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 80, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  '././lib/images/shower.png',
                                  height: screenHeight * 0.03,
                                  color: Colors.grey[900],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '2 bathrooms',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  '././lib/images/garage.png',
                                  color: Colors.grey[900],
                                  height: screenHeight * 0.03,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'parking',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.grey[900],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(15),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: screenHeight * 0.06,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.surface),
                        child: Center(
                          child: Text(
                            'View Details',
                            style: TextStyle(
                                fontSize: screenHeight * 0.023,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
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
