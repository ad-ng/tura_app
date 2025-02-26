import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/features/shares/presentation/bloc/createShareCubit.dart';

class ShareButtonComponents {
  UserModel? userToShare;

  Future openDialog(
          BuildContext context,
          TextEditingController searchController,
          List<UserModel> filteredUsers,
          List<UserModel> allUsers,
          Function filterUsers,
          int propertyId) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<CreateShareCubit, CreateShareState>(
                builder: (context, state) {
                  return AlertDialog(
                    title: Text(
                      'Share Property',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final result = await Share.share(
                            'check out my website https://www.turaestate.com',
                            subject: 'Look what I made!',
                          );

                          if (result.status == ShareResultStatus.success) {
                            print('Thank you for sharing my website!');
                          }
                        },
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
                        onPressed: () {
                          if (userToShare != null) {
                            context
                                .read<CreateShareCubit>()
                                .createShare(propertyId, userToShare!.id);
                          }

                          searchController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Share',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                    content: SingleChildScrollView(
                      child: Column(
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
                          userToShare != null
                              ? Container(
                                  color: Theme.of(context).colorScheme.primary,
                                  child: ListTile(
                                    title: Text(userToShare!.fullname!),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          userToShare = null;
                                        });
                                      },
                                      icon: Icon(Icons.cancel),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 200,
                            width: 300,
                            child: ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                final user = filteredUsers[index];
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    userToShare = user;
                                  }),
                                  child: ListTile(
                                    title: Text(
                                      user.fullname!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      '${user.username}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
}
