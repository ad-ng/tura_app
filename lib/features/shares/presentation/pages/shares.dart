import 'package:flutter/material.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';
import 'package:tura_app/features/shares/presentation/widgets/sharesRecieved.dart';
import 'package:tura_app/features/shares/presentation/widgets/sharesSent.dart';

class Shares extends StatefulWidget {
  const Shares({super.key});

  @override
  State<Shares> createState() => _SharesState();
}

class _SharesState extends State<Shares> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
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
            child: TabBarView(
              children: [
                Sharessent(),
                Sharesrecieved(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
