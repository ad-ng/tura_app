import 'package:flutter/material.dart';
import 'package:tura_app/features/Setting/data/datasource/userUpdateApiService.dart';
import 'package:tura_app/features/login/presentation/widgets/myInput.dart';
import 'package:tura_app/features/setting/data/model/changePasswordModel.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  TextEditingController currentPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Change Password',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              'Current Password:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Myinput(
            myBool: false,
            hintText: 'current password',
            isPassword: false,
            controller: currentPasswordController,
            hider: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              'New Password:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Myinput(
            myBool: false,
            hintText: 'new password',
            isPassword: false,
            controller: newPasswordController,
            hider: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              'Confirm Password:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Myinput(
            myBool: false,
            hintText: 'confirm password',
            isPassword: false,
            controller: confirmPasswordController,
            hider: true,
          ),
          GestureDetector(
            onTap: () async {
              if (newPasswordController.text !=
                  confirmPasswordController.text) {
                currentPasswordController.clear();
                newPasswordController.clear();
                confirmPasswordController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'New Password doesn\'t match with Confirm Password'),
                  ),
                );
              } else {
                try {
                  String myMessage =
                      await UserUpdateApiService().changeUserPassword(
                    ChangePasswordModel(
                      newPassword: newPasswordController.text,
                      oldPassword: currentPasswordController.text,
                    ),
                  );
                  currentPasswordController.clear();
                  newPasswordController.clear();
                  confirmPasswordController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(myMessage),
                    ),
                  );
                } catch (e) {
                  currentPasswordController.clear();
                  newPasswordController.clear();
                  confirmPasswordController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                    ),
                  );
                }
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 20,
                bottom: MediaQuery.of(context).size.height * 0.3,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 60,
              child: Center(
                child: Text(
                  'Update Password',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
