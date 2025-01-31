import 'package:flutter/material.dart';
import 'package:tura_app/components/myInput.dart';
import 'package:tura_app/components/socialMedia.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool mybool = false;
final usernameController = TextEditingController();
final passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(183, 96, 125, 139),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 130,
              ),
              Center(
                child: Image.asset(
                  'lib/images/logo.png',
                  height: 100,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Myinput(
                myBool: true,
                hintText: 'username',
                isPassword: false,
                controller: usernameController,
              ),
              Myinput(
                myBool: mybool,
                hintText: 'password',
                isPassword: true,
                controller: passwordController,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 20),
                  child: Text(
                    'Reset password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    usernameController.clear();
                    passwordController.clear();
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black,
                  ),
                  height: 55,
                  child: Center(
                      child: Text(
                    'sign in',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'continue with',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Socialmedia(imageUrl: 'lib/images/google.png'),
                  Socialmedia(imageUrl: 'lib/images/apple.png'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('not a member?'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
