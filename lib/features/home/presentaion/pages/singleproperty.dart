import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tura_app/features/home/data/datasources/remote/propertiesapiservice.dart';
import 'package:tura_app/features/home/data/repositories/properties_repo_impl.dart';
import 'package:tura_app/features/home/presentaion/cubit/singlePropertyCubit.dart';

class Singleproperty extends StatefulWidget {
  final String slug;
  Singleproperty({super.key, required this.slug});

  @override
  State<Singleproperty> createState() => _SinglepropertyState();
}

int imgIndex = 0;

class _SinglepropertyState extends State<Singleproperty> {
  final _propertiesRepo = PropertiesRepoImpl(PropertiesApiService());

  @override
  Widget build(BuildContext context) {
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
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: screenHeight * 0.32,
                            child: Image.network(property.imageUrls![imgIndex]),
                          ),
                          Container(
                            height: screenWidth * 0.2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: property.imageUrls!.length,
                              itemBuilder: (context, index) {
                                // return Image.asset(snapshot.data!.imageUrls![index]);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imgIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Image.network(
                                      property.imageUrls![index],
                                    ),
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
                        ],
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          )),
    );
  }
}
