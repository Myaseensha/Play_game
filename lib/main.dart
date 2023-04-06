import 'package:flutter/material.dart';
import 'package:play_game_machine_test/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/playscreen_db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayScreenProvider(
        [
          'a',
          'b',
          'c',
          'd',
          'e',
          'f',
          'g',
          'h',
          'i',
          'j',
          'k',
          'l',
          'm',
          'n',
          'o',
          'p',
          'q',
          'r',
          's',
          't',
          'u',
          'v',
          'w',
          'x',
          'y',
          'z'
        ],
        5,
        5,
      ),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
          )),
    );
  }
}
