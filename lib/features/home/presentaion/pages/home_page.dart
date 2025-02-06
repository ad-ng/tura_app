import 'package:flutter/material.dart';
import 'package:tura_app/features/home/presentaion/widgets/myBottomNavBar.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';
import 'package:tura_app/features/home/presentaion/widgets/mydrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int currentIndex = 0;
final _screens = [
  Center(
    child: Text('H O M E   P A G E'),
  ),
  Center(
    child: Text('S H A R E S   P A G E'),
  ),
  Center(
    child: Text('S E A R C H   P A G E'),
  ),
  Center(
    child: Text('P R O F I L E   P A G E'),
  )
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    //ouble screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            myappbar(screenHeight: screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
            ),
            _screens[currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: Mybottomnavbar(
        currentIndex: currentIndex,
        ontap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
