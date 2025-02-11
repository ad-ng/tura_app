import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      width: screenWidth * 0.6,
      child: ListView(
        children: [
          // DrawerHeader(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(20),
          //     child: Image.network(
          //       'https://d1covwzj3ggua9.cloudfront.net/user/Adolphe.jpg',
          //       height: 10,
          //       width: 10,
          //     ),
          //   ),
          // ),
          Padding(
            padding:
                const EdgeInsets.only(top: 65, left: 28, right: 28), //all(28),
            child: Image.asset(
              './././lib/images/logo.png',
              color: Theme.of(context).colorScheme.secondary,
              height: screenHeight * 0.1,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),

          ListTile(
            leading: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.secondary),
            title: Text(
              'settings',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite_sharp,
                color: Theme.of(context).colorScheme.secondary),
            title: Text(
              'favorites',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.sell,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text('sell property',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.contact_phone_sharp,
                color: Theme.of(context).colorScheme.secondary),
            title: Text('contact us',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.secondary),
            title: Text('log out',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'loginPage');
            },
          )
        ],
      ),
    );
  }
}
