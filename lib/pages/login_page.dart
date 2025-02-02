import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/components/myInput.dart';
import 'package:tura_app/components/socialMedia.dart';
import 'package:tura_app/statemanagement/loginCubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool mybool = true;
bool isPassword = false;
final usernameController = TextEditingController();
final passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.message}',
              ),
            ),
          );
        }
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, 'homePage');
        }
      },
      child: Scaffold(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Myinput(
                        myBool: false,
                        hintText: 'username',
                        isPassword: false,
                        controller: usernameController,
                        hider: false,
                      ),
                      Myinput(
                        myBool: mybool,
                        hintText: 'password',
                        isPassword: isPassword,
                        controller: passwordController,
                        hider: true,
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black,
                        ),
                        height: 55,
                        child: Center(
                          child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return CircularProgressIndicator
                                    .adaptive(); // Show loading indicator
                              }
                              return GestureDetector(
                                onTap: () {
                                  _formKey.currentState!.validate();
                                  // Get the username and password from the text fields
                                  final username = usernameController.text;
                                  final password = passwordController.text;

                                  // Trigger the login method in the Cubit
                                  context
                                      .read<LoginCubit>()
                                      .login(username, password);
                                },
                                child: Text(
                                  'sign in',
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
                SizedBox(
                  height: 20,
                ),
                // BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                //   if (state is LoginSuccess) {
                //     UserModel login = state.response;
                //     return Text('${login.email}');
                //   }
                //   return SizedBox.shrink();
                // }),
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
      ),
    );
  }
}
