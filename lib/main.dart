// import 'package:app_fic/pages/splash/splash_page.dart';
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
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: light,
        home: const AuthPage(),
      ),
    );
  }
}