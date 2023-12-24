// import 'package:app_fic/pages/splash/splash_page.dart';
import 'package:app_fic/bloc/Login/login_bloc.dart';
import 'package:app_fic/bloc/Logout/logout_bloc.dart';
import 'package:app_fic/bloc/category/category_bloc.dart';
import 'package:app_fic/bloc/product/product_bloc.dart';
import 'package:app_fic/pages/Data/DataResources/auth_local_datasources.dart';
import 'package:app_fic/pages/dashboard/dashboard.dart';
import 'package:app_fic/utilis/light_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_fic/pages/auth/auth_page.dart';
import 'bloc/Register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: light,
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if( snapshot.hasData && snapshot.data!) {
              return const DashboardPage();
            } else {
              return const AuthPage();
            }
          },
        )),
    );
  }
}
