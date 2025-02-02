import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/pages/register_page.dart';
import 'package:tura_app/network/dioService.dart';
import 'package:tura_app/pages/home_page.dart';
import 'package:tura_app/pages/login_page.dart';
import 'package:tura_app/repos/logIn_repo.dart';
import 'package:tura_app/statemanagement/loginCubit.dart';

void main() {
  DioService.instance.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(LoginRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
        routes: {
          'homePage': (context) => const HomePage(),
          'registerPage': (context) => const RegisterPage(),
          'loginPage': (context) => const LoginPage()
        },
      ),
    );
  }
}
