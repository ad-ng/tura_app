import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/core/theme/light_mode.dart';
import 'package:tura_app/core/theme/theme_cubit.dart';
import 'package:tura_app/features/favorites/presentation/pages/favorites.dart';
import 'package:tura_app/features/home/data/datasources/remote/propertiesapiservice.dart';
import 'package:tura_app/features/home/data/repositories/properties_repo_impl.dart';
import 'package:tura_app/features/home/presentaion/cubit/propertiesCubit.dart';
import 'package:tura_app/features/home/presentaion/cubit/singlePropertyCubit.dart';
import 'package:tura_app/features/profile/data/datasources/remote/userapiservice.dart';
import 'package:tura_app/features/profile/data/repositories/user_repo_impl.dart';
import 'package:tura_app/features/profile/presentaion/bloc/userCubit.dart';
import 'package:tura_app/features/register/data/datasources/registerApiService.dart';
import 'package:tura_app/features/register/data/repository/register_repo_impl.dart';
import 'package:tura_app/features/register/presentaion/bloc/registerCubit.dart';
import 'package:tura_app/features/register/presentaion/pages/register_page.dart';
import 'package:tura_app/features/shares/data/datasources/shareapiservice.dart';
import 'package:tura_app/features/shares/data/repositories/share_repo_impl.dart';
import 'package:tura_app/features/shares/presentation/bloc/createShareCubit.dart';
import 'package:tura_app/features/shares/presentation/bloc/sharesRecievedCubit.dart';
import 'package:tura_app/features/shares/presentation/bloc/sharesSentCubit.dart';
import 'package:tura_app/config/network/dioService.dart';
import 'package:tura_app/features/home/presentaion/pages/home_page.dart';
import 'package:tura_app/features/login/presentation/pages/login_page.dart';
import 'package:tura_app/features/login/data/datasources/loginApiService.dart';
import 'package:tura_app/features/login/presentation/bloc/loginCubit.dart';
import 'package:tura_app/features/shares/presentation/bloc/wholeShareTree.dart';

void main() {
  DioService.instance.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final registerRepo = RegisterRepoImpl(Registerapiservice());
    final _userRepo = UserRepoImpl(UserApiService());
    final _propertiesRepo = PropertiesRepoImpl(PropertiesApiService());
    final _shareRepo = ShareRepoImpl(ShareApiService());

    final slug = 'slug';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(LoginApiService())),
        BlocProvider(create: (context) => Registercubit(registerRepo)),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => PropertiesCubit(_propertiesRepo)),
        BlocProvider(create: (context) => SharesSentCubit(_shareRepo)),
        BlocProvider(create: (context) => SharesrecievedCubit(_shareRepo)),
        BlocProvider(create: (context) => CreateShareCubit(_shareRepo)),
        BlocProvider(create: (context) => Wholesharetree(_shareRepo)),
        BlocProvider(create: (context) => UserCubit(_userRepo)),
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
          'favoritePage': (context) => const Favorites_page()
        },
      ),
    );
  }
}
