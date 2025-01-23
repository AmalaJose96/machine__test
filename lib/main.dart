import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/src/features/login/data/repositories/home_repository_impl.dart';
import 'package:machine_test/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:machine_test/src/features/login/presentation/pages/home.dart';
import 'package:machine_test/src/features/login/presentation/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthRepositoryImpl()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Machine test',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: RegisterPage()),
    );
  }
}
