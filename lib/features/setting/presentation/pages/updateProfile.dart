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

class UpdateProfile extends StatefulWidget {
  final UserModel user;
  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController phoneNumberController;
  final TextEditingController addressController;
  final TextEditingController genderController;

  const UpdateProfile({
    super.key,
    required this.user,
    required this.fullnameController,
    required this.usernameController,
    required this.emailController,
    required this.dateController,
    required this.phoneNumberController,
    required this.addressController,
    required this.genderController,
  });

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File? _pickedImage; // To store the picked image locally

  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data if needed
    widget.fullnameController.text = widget.user.fullname ?? '';
    widget.usernameController.text = widget.user.username ?? '';
    widget.emailController.text = widget.user.email ?? '';
    widget.phoneNumberController.text = widget.user.phoneNumber ?? '';
    widget.dateController.text = widget.user.dob ?? '';
    widget.addressController.text = widget.user.address ?? '';
    widget.genderController.text = widget.user.gender ?? '';
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
        await UserUpdateApiService()
            .updateImage(widget.user.username, _pickedImage!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Profile picture updated successfully')),
          );
        }
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: _pickedImage != null
                      ? Image.file(
                          _pickedImage!,
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget.user.profileImg ?? '',
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.person,
                            size: 100,
                          ),
                        ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.add_a_photo,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Full Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Fullname',
                    isPassword: false,
                    controller: widget.fullnameController,
                    hider: false,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Username',
                    isPassword: false,
                    controller: widget.usernameController,
                    hider: false,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Email',
                    isPassword: false,
                    controller: widget.emailController,
                    hider: false,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Phone Number',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Phone Number',
                    isPassword: false,
                    controller: widget.phoneNumberController,
                    hider: false,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Address',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Myinput(
                    myBool: true,
                    hintText: 'Address',
                    isPassword: false,
                    controller: widget.addressController,
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
                            const Text(
                              'Date Of Birth',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            DobInput(dobController: widget.dateController),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gender',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            GenderPicker(
                                genderController: widget.genderController),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    height: 50,
                    child: Center(
                      child: BlocBuilder<Registercubit, RegisterState>(
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return GestureDetector(
                            onTap: () async {
                              try {
                                await UserUpdateApiService().updateUser(
                                  UpdateUserModel(
                                    fullname: widget.fullnameController.text,
                                    phoneNumber:
                                        widget.phoneNumberController.text,
                                    dob: widget.dateController.text,
                                    gender: widget.genderController.text,
                                    address: widget.addressController.text,
                                  ),
                                  widget.user.username,
                                );
                                if (mounted) {
                                  Navigator.pushNamed(context, 'settingPage');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Profile updated successfully')),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to update profile: $e')),
                                  );
                                }
                              }
                            },
                            child: const Text(
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
