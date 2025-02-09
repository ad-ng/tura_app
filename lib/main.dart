import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/core/theme/light_mode.dart';
import 'package:tura_app/core/theme/theme_cubit.dart';
import 'package:tura_app/features/home/data/datasources/remote/propertiesapiservice.dart';
import 'package:tura_app/features/home/data/repositories/properties_repo_impl.dart';
import 'package:tura_app/features/home/presentaion/cubit/propertiesCubit.dart';
import 'package:tura_app/features/home/presentaion/cubit/singlePropertyCubit.dart';
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
  DioService.instance.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final registerApiService = Registerapiservice();
    //final registerRepo = RegisterRepoImpl(registerApiService);
    final registerRepo = RegisterRepoImpl(Registerapiservice());
    final _propertiesRepo = PropertiesRepoImpl(PropertiesApiService());
    final slug = 'slug';
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(LoginApiService())),
        BlocProvider(create: (context) => Registercubit(registerRepo)),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => PropertiesCubit(_propertiesRepo)),
        BlocProvider(
            create: (context) => SinglePropertyCubit(_propertiesRepo, slug))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        //home: const LoginPage(), // Initial page is LoginPage
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          'homePage': (context) => const HomePage(),
          'registerPage': (context) => const RegisterPage(),
          'loginPage': (context) => const LoginPage(),
        },
      ),
    );
  }
}
