import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/components/myInput.dart';
import 'package:tura_app/components/socialMedia.dart';
import 'package:tura_app/features/register/data/model/registerModel.dart';
import 'package:tura_app/features/register/presentaion/bloc/registerCubit.dart';
import 'package:tura_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final passwordController = TextEditingController();
final fullnameController = TextEditingController();
final usernameController = TextEditingController();
final emailController = TextEditingController();
final phoneNumberController = TextEditingController();
final dateController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate() async {
      DateTime? _picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
      );

      if (_picked != null) {
        setState(() {
          dateController.text = _picked.toString().split(" ")[0];
        });
      }
    }

    return BlocListener<Registercubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.message}',
              ),
            ),
          );
        }
        if (state is RegisterSuccess) {
          Navigator.pushNamed(context, 'homePage');
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(183, 96, 125, 139),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset(
                    'lib/images/logo.png',
                    height: 70,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(
                    children: [
                      Myinput(
                        myBool: true,
                        hintText: 'Fullname',
                        isPassword: false,
                        controller: fullnameController,
                        hider: false,
                      ),
                      Myinput(
                        myBool: true,
                        hintText: 'Username',
                        isPassword: false,
                        controller: usernameController,
                        hider: false,
                      ),
                      Myinput(
                        myBool: true,
                        hintText: 'Email',
                        isPassword: false,
                        controller: emailController,
                        hider: false,
                      ),
                      Myinput(
                        myBool: true,
                        hintText: 'PhoneNumber',
                        isPassword: false,
                        controller: phoneNumberController,
                        hider: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                              height: 45,
                              child: TextFormField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  label: Text('DATE'),
                                  prefixIcon: Icon(Icons.calendar_month),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Myinput(
                        myBool: true,
                        hintText: 'password',
                        isPassword: true,
                        controller: passwordController,
                        hider: true,
                      ),
                      Myinput(
                        myBool: true,
                        hintText: 'confirm password',
                        isPassword: true,
                        controller: passwordController,
                        hider: true,
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
                                onTap: () {
                                  //_formKey.currentState!.validate();
                                  // Get the username and password from the text fields

                                  // Trigger the login method in the Cubit
                                  context.read<Registercubit>().signup(
                                        RegisterModel(
                                          username: usernameController.text,
                                          fullname: fullnameController.text,
                                          email: emailController.text,
                                          phoneNumber:
                                              phoneNumberController.text,
                                          dob: dateController.text,
                                          gender: 'male',
                                          password: passwordController.text,
                                        ),
                                      );
                                },
                                child: Text(
                                  'sign up',
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      height: 0.5,
                      width: 120,
                    ),
                    Text(
                      'continue with',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      height: 0.5,
                      width: 115,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Socialmedia(imageUrl: 'lib/images/google.png'),
                    Socialmedia(imageUrl: 'lib/images/facebook.png'),
                    Socialmedia(imageUrl: 'lib/images/apple.png'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
