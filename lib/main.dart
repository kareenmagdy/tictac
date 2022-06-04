import 'package:flutter/material.dart';
import 'package:tictac/constants.dart';
import 'package:tictac/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        shadowColor: shadowColor,

      ),
      home: const HomePage(),
    );
  }
}
