import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/register/data/datasources/registerApiService.dart';
import 'package:tura_app/features/register/data/repository/register_repo_impl.dart';
import 'package:tura_app/features/register/presentaion/bloc/registerCubit.dart';
import 'package:tura_app/features/register/presentaion/pages/register_page.dart';
import 'package:tura_app/network/dioService.dart';
import 'package:tura_app/features/home/presentaion/pages/home_page.dart';
import 'package:tura_app/features/login/presentation/pages/login_page.dart';
import 'package:tura_app/features/login/data/datasources/loginApiService.dart';
import 'package:tura_app/features/login/presentation/bloc/loginCubit.dart';

void main() {
  DioService.instance.setup(); // Ensure Dio is set up correctly
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 1: Set up Dio and RegisterApiService

    final registerApiService = Registerapiservice(); // Passing Dio instance
    final registerRepo =
        RegisterRepoImpl(registerApiService); // Create RegisterRepoImpl

    return MultiBlocProvider(
      providers: [
        // Step 2: Providing the LoginCubit
        BlocProvider(
          create: (context) => LoginCubit(
            LoginApiService(),
          ),
        ),
        // Step 3: Providing the RegisterCubit with the correct dependencies
        BlocProvider(
          create: (context) =>
              Registercubit(registerRepo), // Injecting RegisterRepoImpl
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(), // Initial page is LoginPage
        routes: {
          'homePage': (context) => const HomePage(),
          'registerPage': (context) => const RegisterPage(),
          'loginPage': (context) => const LoginPage(),
        },
      ),
    );
  }
}
