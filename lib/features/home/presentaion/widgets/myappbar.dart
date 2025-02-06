import 'package:flutter/material.dart';

class myappbar extends StatelessWidget {
  const myappbar({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                '././lib/images/options.png',
                color: Theme.of(context).colorScheme.secondary,
                height: screenHeight * 0.03,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Image.asset(
            '././lib/images/logo.png',
            color: Theme.of(context).colorScheme.secondary,
            height: screenHeight * 0.07,
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                '././lib/images/bell.png',
                color: Theme.of(context).colorScheme.secondary,
                height: screenHeight * 0.03,
              ))
        ],
      ),
    );
  }
}
