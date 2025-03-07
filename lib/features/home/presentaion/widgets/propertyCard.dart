import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tura_app/features/favorites/data/datasources/favoritesApiService.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/features/home/presentaion/pages/singleproperty.dart';

class Propertycard extends StatefulWidget {
  final PropertiesModel property;
  const Propertycard({super.key, required this.property});

  @override
  State<Propertycard> createState() => _PropertycardState();
}

class _PropertycardState extends State<Propertycard> {
  final myController = CarouselSliderController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          //height: screenHeight * 0.63,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CarouselSlider.builder(
                  itemCount: widget.property.imageUrls!.length,
                  carouselController: myController,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      child: Image.network(
                        widget.property.imageUrls![index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: screenHeight * 0.301,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  '${widget.property.title}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  widget.property.hasPool!
                      ? Container(
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Pool',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        )
                      : Container(),
                  widget.property.hasParking!
                      ? Container(
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.yellow[900],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Parking',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              Container(
                color: Colors.grey,
                height: 1,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
              ),
              GestureDetector(
                onTap: () async {
                  bool isFavorited = await Favoritesapiservice()
                      .checkFavorite(widget.property.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Singleproperty(
                        isFavorited: isFavorited,
                        slug: widget.property.slug!,
                        propertyId: widget.property.id!,
                      );
                    }),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: screenHeight * 0.06,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: widget.property.isForSale!
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(15),
          ),
          height: screenHeight * 0.035,
          width: screenWidth * 0.2,
          margin: EdgeInsets.only(
              left: screenWidth * 0.08, top: screenHeight * 0.02),
          child: Center(
            child: Text(
              widget.property.isForSale! ? 'For Sale' : 'For Rent',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          height: screenHeight * 0.04,
          margin: EdgeInsets.only(
              left: screenWidth * 0.13, top: screenWidth * 0.585),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            '${widget.property.price} Rwf',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.15, left: 5),
          child: IconButton(
            onPressed: () {
              myController.previousPage();
            },
            icon: Icon(
              Icons.chevron_left,
              color: Colors.yellow[900],
              size: 40,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: screenHeight * 0.15, left: screenWidth * 0.83),
          child: IconButton(
            onPressed: () {
              myController.nextPage();
            },
            icon: Icon(
              Icons.chevron_right,
              color: Colors.yellow[900],
              size: 40,
            ),
          ),
        )
      ],
    );
  }
}
