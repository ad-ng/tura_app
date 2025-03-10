import 'package:flutter/material.dart';

class Eachnotificationcard extends StatefulWidget {
  const Eachnotificationcard({super.key});

  @override
  State<Eachnotificationcard> createState() => _EachnotificationcardState();
}

class _EachnotificationcardState extends State<Eachnotificationcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: 6,
        right: 6,
        top: 6,
      ),
      child: ListTile(
        minVerticalPadding: 5,
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          height: 40,
          width: 40,
          color: Colors.amber,
        ),
        title: Text('notification title'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'hghghhvhfvfdsewewethbhbhvgsawaeryggqqqqqqqqqqqrrrrrrrrr',
            ),
            Text('time'),
          ],
        ),
        trailing: Icon(Icons.more_vert_outlined),
      ),
    );
  }
}
