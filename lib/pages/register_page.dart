import 'package:flutter/material.dart';
import 'package:tura_app/components/myInput.dart';
import 'package:tura_app/components/socialMedia.dart';
import 'package:tura_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final passwordController = TextEditingController();
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

    return Scaffold(
      backgroundColor: Color.fromARGB(183, 96, 125, 139),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
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
              Form(
                child: Column(
                  children: [
                    Myinput(
                      myBool: true,
                      hintText: 'Fullname',
                      isPassword: true,
                      controller: passwordController,
                      hider: false,
                    ),
                    Myinput(
                      myBool: true,
                      hintText: 'Username',
                      isPassword: true,
                      controller: passwordController,
                      hider: false,
                    ),
                    Myinput(
                      myBool: true,
                      hintText: 'Email',
                      isPassword: true,
                      controller: passwordController,
                      hider: false,
                    ),
                    Myinput(
                      myBool: true,
                      hintText: 'PhoneNumber',
                      isPassword: true,
                      controller: passwordController,
                      hider: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 50,
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
                    )
                  ],
                ),
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
                height: 20,
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
                height: 55,
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
    );
  }
}
