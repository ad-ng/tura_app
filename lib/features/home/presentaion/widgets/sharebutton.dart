import 'package:flutter/material.dart';

class MyCustomShareButton extends StatefulWidget {
  const MyCustomShareButton({super.key});

  @override
  State<MyCustomShareButton> createState() => _MyCustomShareButtonState();
}

class _MyCustomShareButtonState extends State<MyCustomShareButton> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        //final result = await Share.share(
        //  'check out my website https://example.com');

        // if (result.status == ShareResultStatus.success) {
        //Shar
        print('Thank you for sharing my website!');
        // }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        margin: EdgeInsets.only(
          left: screenWidth * 0.64,
          top: screenHeight * 0.24,
        ),
        height: screenHeight * 0.05,
        width: screenWidth * 0.27,
        decoration: BoxDecoration(
            color: Colors.green[300], borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.share),
            Text(
              'share',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
