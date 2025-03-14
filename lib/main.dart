import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tura_app/core/theme/dark_mode.dart';
import 'package:tura_app/core/theme/light_mode.dart';
import 'package:tura_app/core/theme/theme_cubit.dart';
import 'package:tura_app/features/contact%20us/presentaion/pages/contact_page.dart';
import 'package:tura_app/features/favorites/data/datasources/favoritesApiService.dart';
import 'package:tura_app/features/favorites/data/repositories/favorites_repo_impl.dart';
import 'package:tura_app/features/favorites/presentation/bloc/favoritesCubit.dart';
import 'package:tura_app/features/favorites/presentation/pages/favorites.dart';
import 'package:tura_app/features/home/data/datasources/remote/propertiesapiservice.dart';
import 'package:tura_app/features/home/data/repositories/properties_repo_impl.dart';
import 'package:tura_app/features/home/presentaion/cubit/propertiesCubit.dart';
import 'package:tura_app/features/home/presentaion/cubit/singlePropertyCubit.dart';
import 'package:tura_app/features/notification/data/datasource/notificationApiService.dart';
import 'package:tura_app/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:tura_app/features/notification/presentation/cubit/allnotiCubit.dart';
import 'package:tura_app/features/notification/presentation/cubit/unreadCubit.dart';
import 'package:tura_app/features/profile/data/datasources/remote/userapiservice.dart';
import 'package:tura_app/features/profile/data/repositories/user_repo_impl.dart';
import 'package:tura_app/features/profile/presentaion/bloc/userCubit.dart';
import 'package:tura_app/features/register/data/datasources/registerApiService.dart';
import 'package:tura_app/features/register/data/repository/register_repo_impl.dart';
import 'package:tura_app/features/register/presentaion/bloc/registerCubit.dart';
import 'package:tura_app/features/register/presentaion/pages/register_page.dart';
import 'package:tura_app/features/setting/presentation/pages/setting_page.dart';
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

void main() async {
  DioService.instance.setup();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final registerRepo = RegisterRepoImpl(Registerapiservice());
    final userRepo = UserRepoImpl(UserApiService());
    final propertiesRepo = PropertiesRepoImpl(PropertiesApiService());
    final shareRepo = ShareRepoImpl(ShareApiService());
    final favoritesRepo = FavoritesRepoImpl(Favoritesapiservice());
    final notificationRepo = NotificationRepoImpl(NotificationApiService());

    final slug = 'slug';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(LoginApiService())),
        BlocProvider(create: (context) => Registercubit(registerRepo)),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => PropertiesCubit(propertiesRepo)),
        BlocProvider(create: (context) => SharesSentCubit(shareRepo)),
        BlocProvider(create: (context) => SharesrecievedCubit(shareRepo)),
        BlocProvider(create: (context) => CreateShareCubit(shareRepo)),
        BlocProvider(create: (context) => Wholesharetree(shareRepo)),
        BlocProvider(create: (context) => UserCubit(userRepo)),
        BlocProvider(create: (context) => Favoritescubit(favoritesRepo)),
        BlocProvider(create: (context) => AllNotiCubit(notificationRepo)),
        BlocProvider(create: (context) => UnreadCubit(notificationRepo)),
        BlocProvider(
            create: (context) => SinglePropertyCubit(propertiesRepo, slug))
      ],
      child: BlocBuilder<ThemeCubit, ThemeModeState>(
          builder: (context, themeMode) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeMode == ThemeModeState.light
              ? ThemeMode.light
              : ThemeMode.dark,
          //home: const LoginPage(), // Initial page is LoginPage
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            'homePage': (context) => const HomePage(),
            'registerPage': (context) => const RegisterPage(),
            'loginPage': (context) => const LoginPage(),
            'favoritePage': (context) => const Favorites_page(),
            'contactPage': (context) => const ContactPage(),
            'settingPage': (context) => const SettingPage()
          },
        );
      }),
    );
  }
}
