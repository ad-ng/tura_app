import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tura_app/features/favorites/data/datasources/favoritesApiService.dart';
import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';
import 'package:tura_app/features/favorites/presentation/bloc/favoritesCubit.dart';
import 'package:tura_app/features/home/presentaion/pages/singleproperty.dart';

class Favoritecard extends StatelessWidget {
  final Favoritesmodel favotite;
  const Favoritecard({super.key, required this.favotite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: ListTile(
          title: Text(
            favotite.property.title!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "${NumberFormat('#,###').format(favotite.property.price!)} Rwf",
            style: TextStyle(
              color: Colors.green[400],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showAdaptiveDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: Center(
                      child: Text(
                        'Are you sure ?',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await Favoritesapiservice()
                                .deleteFavorite(favotite.propertyId);
                            BlocProvider.of<Favoritescubit>(context)
                                .fetchProps();
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red[300],
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Singleproperty(slug: favotite.property.slug!),
                ),
              );
            },
            child: Image.network(favotite.property.imageUrls![0]),
          ),
        ),
      ),
    );
  }
}
