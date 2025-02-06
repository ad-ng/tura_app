import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Mybottomnavbar extends StatefulWidget {
  final int currentIndex;
  final ontap;
  Mybottomnavbar({super.key, required this.currentIndex, required this.ontap});

  @override
  State<Mybottomnavbar> createState() => _MybottomnavbarState();
}

class _MybottomnavbarState extends State<Mybottomnavbar> {
  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _items = [
      SalomonBottomBarItem(
        icon: Image.asset(
          '././lib/images/home.png',
          height: screenHeight * 0.03,
        ),
        title: const Text('HOME'),
      ),
      SalomonBottomBarItem(
        icon: Image.asset(
          '././lib/images/cloud-share.png',
          height: screenHeight * 0.03,
        ),
        title: const Text('SHARES'),
      ),
      SalomonBottomBarItem(
        icon: Image.asset(
          '././lib/images/guide-alt.png',
          height: screenHeight * 0.03,
        ),
        title: const Text('GUIDE'),
      ),
      SalomonBottomBarItem(
          icon: Image.asset(
            '././lib/images/user.png',
            height: screenHeight * 0.03,
          ),
          title: Text('PROFILE'))
    ];

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: SalomonBottomBar(
        items: _items,
        duration: Duration(seconds: 1),
        currentIndex: widget.currentIndex,
        onTap: widget.ontap,
      ),
    );
  }
}
