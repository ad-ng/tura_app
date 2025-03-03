import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tura_app/features/home/presentaion/widgets/myFilter.dart';

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
                '././lib/images/menu.png',
                color: Theme.of(context).colorScheme.secondary,
                height: screenHeight * 0.045,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          SizedBox(),
          Image.asset(
            '././lib/images/logo.png',
            color: Theme.of(context).colorScheme.secondary,
            height: screenHeight * 0.07,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => showPopover(
                  barrierDismissible: false,
                  context: context,
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.9,
                  direction: PopoverDirection.top,
                  bodyBuilder: (context) {
                    return MyFilter();
                  },
                ),
                icon: Image.asset(
                  '././lib/images/options.png',
                  color: Theme.of(context).colorScheme.secondary,
                  height: screenHeight * 0.025,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  '././lib/images/bell.png',
                  color: Theme.of(context).colorScheme.secondary,
                  height: screenHeight * 0.03,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
