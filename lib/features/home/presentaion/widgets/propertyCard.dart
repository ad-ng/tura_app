import 'package:flutter/material.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';

class Propertycard extends StatelessWidget {
  final PropertiesModel property;
  const Propertycard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        height: screenHeight * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.network('${property.imageUrls![0]}'),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${property.title}',
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
                    '${property.place!.name}',
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
              padding: const EdgeInsets.only(left: 20, right: 60, top: 10),
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
                        '${property.size} m',
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
                        '${property.bedrooms} bedrooms',
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
                        '${property.bathrooms} bathrooms',
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
  }
}
