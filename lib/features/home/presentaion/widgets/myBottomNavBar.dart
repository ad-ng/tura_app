import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Mybottomnavbar extends StatefulWidget {
  final int currentIndex;
  final ontap;
  Mybottomnavbar({super.key, required this.currentIndex, required this.ontap});

  @override
  State<Mybottomnavbar> createState() => _MybottomnavbarState();
}

final _items = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text('home'),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.swap_horizontal_circle_sharp),
    title: const Text('shares'),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text('search'),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text('profile'),
  ),
];

class _MybottomnavbarState extends State<Mybottomnavbar> {
  @override
  Widget build(BuildContext context) {
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
