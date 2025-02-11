import 'package:flutter/material.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';

class Shares extends StatelessWidget {
  const Shares({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            myappbar(screenHeight: screenHeight),
            TabBar(
              dividerHeight: 0,
              tabs: [
                Tab(
                  text: 'shares sent',
                  icon: Icon(Icons.arrow_upward_sharp),
                ),
                Tab(
                  text: 'shares received',
                  icon: Icon(
                    Icons.arrow_downward_outlined,
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Center(
                  child: Text('shares sent'),
                ),
                Center(
                  child: Text('shares recieved'),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
