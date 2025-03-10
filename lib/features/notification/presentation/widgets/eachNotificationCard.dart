import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

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
        trailing: IconButton(
          onPressed: () {
            showPopover(
              context: context,
              height: 100,
              arrowHeight: 0,
              width: MediaQuery.of(context).size.width * 0.5,
              direction: PopoverDirection.bottom,
              bodyBuilder: (context) {
                return Column(
                  children: [
                    Container(
                      color: Colors.amber,
                      height: 50,
                      width: 300,
                      child: ListTile(
                        title: Text('Mark as read'),
                        trailing: Icon(Icons.open_in_browser_outlined),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      height: 50,
                      width: 300,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.more_vert_outlined),
        ),
      ),
    );
  }
}
