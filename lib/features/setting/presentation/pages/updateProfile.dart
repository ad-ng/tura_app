import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tura_app/features/Setting/data/datasource/userUpdateApiService.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/features/login/presentation/widgets/myInput.dart';
import 'package:tura_app/features/register/presentaion/bloc/registerCubit.dart';
import 'package:tura_app/features/register/presentaion/widgets/dob_input.dart';
import 'package:tura_app/features/register/presentaion/widgets/gender_picker.dart';
import 'package:tura_app/features/setting/data/model/updateUserMoodel.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile(
      {super.key,
      required this.user,
      required this.fullnameController,
      required this.usernameController,
      required this.emailController,
      required this.dateController,
      required this.phoneNumberController,
      required this.addressController,
      required this.genderController});

  final UserModel user;

  final TextEditingController fullnameController;

  final TextEditingController usernameController;

  final TextEditingController emailController;

  final TextEditingController phoneNumberController;

  final TextEditingController dateController;

  final TextEditingController genderController;

  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: Image.network(
                    user.profileImg!,
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      UserUpdateApiService()
                          .updateImage(user.username, File(image.path));
                      print('image picked');
                      print(
                        UserUpdateApiService().updateImage(
                          user.username,
                          File(image.path),
                        ),
                      );
                    } else {
                      print('image not picked');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 140),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Full Name',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Fullname',
                    isPassword: false,
                    controller: fullnameController,
                    hider: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'UserName',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Username',
                    isPassword: false,
                    controller: usernameController,
                    hider: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Email',
                    isPassword: false,
                    controller: emailController,
                    hider: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Phone NUmber',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'PhoneNumber',
                    isPassword: false,
                    controller: phoneNumberController,
                    hider: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Address',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Address',
                    isPassword: false,
                    controller: addressController,
                    hider: false,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date Of Birth',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            DobInput(dobController: dateController),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            GenderPicker(genderController: genderController),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    height: 50,
                    child: Center(
                      child: BlocBuilder<Registercubit, RegisterState>(
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return CircularProgressIndicator
                                .adaptive(); // Show loading indicator
                          }
                          return GestureDetector(
                            onTap: () async {
                              await UserUpdateApiService().updateUser(
                                UpdateUserModel(
                                  fullname: fullnameController.text,
                                  phoneNumber: phoneNumberController.text,
                                  dob: dateController.text,
                                  gender: genderController.text,
                                  address: addressController.text,
                                ),
                                user.username,
                              );
                              Navigator.pushNamed(context, 'settingPage');
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
