import 'package:flutter/material.dart';

class MyCustomShareButton extends StatefulWidget {
  const MyCustomShareButton({super.key});

  @override
  State<MyCustomShareButton> createState() => _MyCustomShareButtonState();
}

TextEditingController searchController = TextEditingController();

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
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Copy link',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Cancel',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Share',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            ],
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search a User To Share',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      // onChanged: _filterProducts,
                    ),
                  ),
                  // Expanded(
                  //   child: FutureBuilder<List<Product>>(
                  //     future: futureProducts,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Center(child: CircularProgressIndicator());
                  //       } else if (snapshot.hasError) {
                  //         return Center(
                  //             child: Text('Error: ${snapshot.error}'));
                  //       } else if (!snapshot.hasData ||
                  //           snapshot.data!.isEmpty) {
                  //         return Center(child: Text('No products found'));
                  //       } else {
                  //         final productsToDisplay =
                  //             searchController.text.isEmpty
                  //                 ? snapshot.data!
                  //                 : filteredProducts;

                  //         return ListView.builder(
                  //           itemCount: productsToDisplay.length,
                  //           itemBuilder: (context, index) {
                  //             final product = productsToDisplay[index];
                  //             return ListTile(
                  //               title: Text(product.name),
                  //               subtitle: Text(
                  //                   '\$${product.price.toString()} - ${product.category}'),
                  //             );
                  //           },
                  //         );
                  //       }
                  //     },
                  //   ),
                  //   actions: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         TextButton(
                  //             onPressed: () {}, child: Text('copy link')),
                  //         Row(
                  //           children: [
                  //             TextButton(
                  //                 onPressed: () {}, child: Text('Cancel')),
                  //             TextButton(onPressed: () {}, child: Text('Send')),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ),
              ],
            ),
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
