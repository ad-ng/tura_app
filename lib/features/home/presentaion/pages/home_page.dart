import 'package:flutter/material.dart';
import 'package:tura_app/features/guide/presention/pages/guide_page.dart';
import 'package:tura_app/features/home/presentaion/widgets/myBottomNavBar.dart';
import 'package:tura_app/features/home/presentaion/widgets/mydrawer.dart';
import 'package:tura_app/features/home/presentaion/widgets/myhome.dart';
import 'package:tura_app/features/profile/presentaion/pages/profile.dart';
import 'package:tura_app/features/shares/presentation/pages/shares.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int currentIndex = 0;
final _screens = [
  MyHome(),
  Shares(),
  GuidePage(),
  Profile(),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    //ouble screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: _screens[currentIndex],
        bottomNavigationBar: Mybottomnavbar(
          currentIndex: currentIndex,
          ontap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
