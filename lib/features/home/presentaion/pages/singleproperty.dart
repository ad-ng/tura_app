import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:tura_app/features/home/data/datasources/remote/propertiesapiservice.dart';
import 'package:tura_app/features/home/data/repositories/properties_repo_impl.dart';
import 'package:tura_app/features/home/presentaion/cubit/singlePropertyCubit.dart';
import 'package:tura_app/features/home/presentaion/widgets/myBottomNavBar.dart';
import 'package:tura_app/features/home/presentaion/widgets/propertyCard.dart';
import 'package:tura_app/features/home/presentaion/widgets/sharebutton.dart';

class Singleproperty extends StatefulWidget {
  final String slug;
  Singleproperty({super.key, required this.slug});

  @override
  State<Singleproperty> createState() => _SinglepropertyState();
}

int imgIndex = 0;
final myController = CarouselSliderController();
int activeIndex = 0;
int currentIndex = 0; //for navbar

class _SinglepropertyState extends State<Singleproperty> {
  final _propertiesRepo = PropertiesRepoImpl(PropertiesApiService());

  @override
  Widget build(BuildContext context) {
    // shareActualFunction() {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('simple test'),
    //     ),
    //   );
    // }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SinglePropertyCubit(_propertiesRepo, widget.slug),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.slug,
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
          body: BlocBuilder<SinglePropertyCubit, PropertyState>(
            builder: (context, state) {
              if (state is PropertiesLoading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (state is PropertyError) {
                print('Error: ${state.message}');

                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is PropertySuccess) {
                final property = state.response;

                return Expanded(
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 20, bottom: 20),
                            child: Text(
                              property.title!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount: property.imageUrls!.length,
                                carouselController: myController,
                                itemBuilder: (context, index, realIndex) {
                                  return Container(
                                    child: Image.network(
                                      property.imageUrls![index],
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
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenHeight * 0.12, left: 5),
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
                                    top: screenHeight * 0.12,
                                    left: screenWidth * 0.83),
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
                              ),
                              MyCustomShareButton(
                                propertyId: property.id!,
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text('Information')),
                                  DataColumn(label: Text('value'))
                                ],
                                rows: <DataRow>[
                                  DataRow(cells: [
                                    DataCell(Text('location')),
                                    DataCell(Text(property.place!.name!))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('price')),
                                    DataCell(Text('${property.price!} Rwf'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('area')),
                                    DataCell(Text('${property.size!} m'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('bedrooms')),
                                    DataCell(Text('${property.bedrooms}'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('bathrooms')),
                                    DataCell(Text('${property.bathrooms}'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('parking')),
                                    DataCell(Icon(property.hasParking!
                                        ? Icons.check_outlined
                                        : Icons.clear))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('year built')),
                                    DataCell(Text(
                                        '${property.yearBuilt!.split('-')[0]}'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('category')),
                                    DataCell(
                                        Text('${property.category!.name!}'))
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).colorScheme.background),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                HtmlWidget(
                                  ''' ${property.details!} ''',
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              'related properties',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                          FutureBuilder(
                            future: PropertiesApiService()
                                .similarProps('${property.id}'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('${snapshot.error.toString()}'),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return SizedBox(
                                  height: screenHeight * 0.55,
                                  width: screenWidth,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      final property = snapshot.data![index];
                                      return Propertycard(property: property);
                                    },
                                  ),
                                );
                              }
                              return SizedBox.shrink();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          bottomNavigationBar: Mybottomnavbar(
            currentIndex: currentIndex,
            ontap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          )),
    );
  }
}
