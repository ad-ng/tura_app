import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';
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
            onPressed: () {},
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
