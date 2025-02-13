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
    Future openDialog() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Share Property',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            content: Column(
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      prefix: Icon(Icons.search),
                      hintText: 'search a user',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {}, child: Text('copy link')),
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: Text('Cancel')),
                      TextButton(onPressed: () {}, child: Text('Send')),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
    return GestureDetector(
      onTap: () async {
        //final result = await Share.share(
        //  'check out my website https://example.com');

        // if (result.status == ShareResultStatus.success) {
        //Shar
        print('Thank you for sharing my website!');
        // }
        openDialog();
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
