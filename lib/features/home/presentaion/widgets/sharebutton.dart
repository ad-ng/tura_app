import 'package:flutter/material.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/features/shares/data/datasources/shareapiservice.dart';

class MyCustomShareButton extends StatefulWidget {
  const MyCustomShareButton({super.key});

  @override
  State<MyCustomShareButton> createState() => _MyCustomShareButtonState();
}

class _MyCustomShareButtonState extends State<MyCustomShareButton> {
  List<UserModel> filterUsers(List<UserModel> users, String query) {
    return users.where((user) {
      final fullNameLower = user.fullname!.toLowerCase();
      final userNameLower = user.username!.toLowerCase();
      final searchLower = query.toLowerCase();

      return fullNameLower.contains(searchLower) ||
          userNameLower.contains(searchLower);
    }).toList();
  }

  late Future<List<UserModel>> futureUsers;
  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUsers = ShareApiService().fetchAllUsers().then((users) {
      setState(() {
        allUsers = users;
        //   filteredUsers = users;
      });
      return users;
    });
    searchController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final query = searchController.text;
    setState(() {
      filteredUsers = filterUsers(allUsers, query);
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onTextChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Future openDialog() => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
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
                      onPressed: () {
                        searchController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Share',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
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
                          ),
                          onChanged: (value) {
                            setState(() {
                              filteredUsers = filterUsers(allUsers, value);
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            return ListTile(
                              title: Text(
                                user.fullname!,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                '${user.username}',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );

    return GestureDetector(
      onTap: () async {
        print('Thank you for sharing my website!');
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
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.share),
            Text(
              'share',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
