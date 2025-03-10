import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/login/presentation/widgets/myInput.dart';
import 'package:tura_app/features/login/presentation/widgets/socialMedia.dart';
import 'package:tura_app/features/login/presentation/bloc/loginCubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool mybool = true;
bool isPassword = false;
final usernameController = TextEditingController();
final passwordController = TextEditingController();
//final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
            ),
          );
        }
        if (state is LoginSuccess) {
          usernameController.clear();
          passwordController.clear();
          Navigator.pushReplacementNamed(context, 'homePage');
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                  //key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            'Forgot password?',
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
                          borderRadius: BorderRadius.circular(10),
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
                                  //_formKey.currentState!.validate();
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
                  height: 35,
                ),
                // BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                //   if (state is LoginSuccess) {
                //     UserModel login = state.response;
                //     return Text('${login.email}');
                //   }
                //   return SizedBox.shrink();
                // }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      height: 0.5,
                      width: MediaQuery.of(context).size.width * 0.35,
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
                        width: MediaQuery.of(context).size.width * 0.3),
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
                    Text('Don\'t have an account?'),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'registerPage'),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
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
