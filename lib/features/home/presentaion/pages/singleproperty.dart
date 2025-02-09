import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tura_app/features/home/presentaion/cubit/singlePropertyCubit.dart';

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
        // body: FutureBuilder<PropertiesModel>(
        //   future: PropertiesApiService().fetchSingleProp(slug),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       // Handle errors
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else {
        //       return Expanded(
        //         child: ListView(
        //           children: [
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(
        //                       left: 25, top: 20, bottom: 20),
        //                   child: Text(
        //                     snapshot.data!.title!,
        //                     style: TextStyle(
        //                       color: Theme.of(context).colorScheme.secondary,
        //                       fontWeight: FontWeight.w500,
        //                       fontSize: 20,
        //                     ),
        //                   ),
        //                 ),
        //                 Container(
        //                   margin: EdgeInsets.symmetric(horizontal: 10),
        //                   height: screenHeight * 0.32,
        //                   child: Image.network(snapshot.data!.imageUrls![0]),
        //                 ),
        //                 Container(
        //                   height: screenWidth * 0.2,
        //                   child: ListView.builder(
        //                     scrollDirection: Axis.horizontal,
        //                     itemCount: snapshot.data!.imageUrls!.length,
        //                     itemBuilder: (context, index) {
        //                       // return Image.asset(snapshot.data!.imageUrls![index]);
        //                       return Padding(
        //                         padding: const EdgeInsets.only(left: 10, top: 5),
        //                         child: Image.network(
        //                           snapshot.data!.imageUrls![index],
        //                         ),
        //                       );
        //                     },
        //                   ),
        //                 ),
        //                 Container(
        //                   margin:
        //                       EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        //                   decoration: BoxDecoration(
        //                       color: Theme.of(context).colorScheme.primary,
        //                       borderRadius: BorderRadius.circular(10)),
        //                   child: Center(
        //                     child: DataTable(columns: <DataColumn>[
        //                       DataColumn(label: Text('Information')),
        //                       DataColumn(label: Text('value'))
        //                     ], rows: <DataRow>[
        //                       DataRow(cells: [
        //                         DataCell(Text('location')),
        //                         DataCell(Text(snapshot.data!.place!.name!))
        //                       ]),
        //                       DataRow(cells: [
        //                         DataCell(Text('price')),
        //                         DataCell(Text('${snapshot.data!.price!} Rwf'))
        //                       ]),
        //                       DataRow(cells: [
        //                         DataCell(Text('area')),
        //                         DataCell(Text('${snapshot.data!.size!} m'))
        //                       ]),
        //                       DataRow(cells: [
        //                         DataCell(Text('bedrooms')),
        //                         DataCell(Text('${snapshot.data!.bedrooms}'))
        //                       ]),
        //                       DataRow(cells: [
        //                         DataCell(Text('bathrooms')),
        //                         DataCell(Text('${snapshot.data!.bathrooms}'))
        //                       ]),
        //                       DataRow(cells: [
        //                         DataCell(Text('parking')),
        //                         DataCell(Icon(snapshot.data!.hasParking!
        //                             ? Icons.check_outlined
        //                             : Icons.clear))
        //                       ]),
        //                       DataRow(cells: [
        //                         DataCell(Text('year built')),
        //                         DataCell(Text(
        //                             '${snapshot.data!.yearBuilt!.split('-')[0]}'))
        //                       ]),
        //                       DataRow(cells: [
        //                         DataCell(Text('category')),
        //                         DataCell(
        //                             Text('${snapshot.data!.category!.name!}'))
        //                       ]),
        //                     ]),
        //                   ),
        //                 ),
        //                 Container(
        //                   margin: EdgeInsets.all(10),
        //                   padding: EdgeInsets.all(13),
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10),
        //                       color: Theme.of(context).colorScheme.background),
        //                   child: Column(
        //                     children: [
        //                       Container(
        //                         margin: EdgeInsets.symmetric(
        //                             vertical: 10, horizontal: 15),
        //                         child: Text(
        //                           'Description',
        //                           style: TextStyle(
        //                             fontSize: 18,
        //                           ),
        //                         ),
        //                       ),
        //                       HtmlWidget(
        //                         ''' ${snapshot.data!.details!} ''',
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       );
        //     }
        //   },
        //),
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
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: screenHeight * 0.32,
                          child: Image.network(property.imageUrls![0]),
                        ),
                        Container(
                          height: screenWidth * 0.2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: property.imageUrls!.length,
                            itemBuilder: (context, index) {
                              // return Image.asset(snapshot.data!.imageUrls![index]);
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Image.network(
                                  property.imageUrls![index],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: DataTable(columns: <DataColumn>[
                              DataColumn(label: Text('Information')),
                              DataColumn(label: Text('value'))
                            ], rows: <DataRow>[
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
                                DataCell(Text('${property.category!.name!}'))
                              ]),
                            ]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.background),
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
                      ],
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ));
  }
}
