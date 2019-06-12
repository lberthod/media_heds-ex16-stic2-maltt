import 'package:flutter/material.dart';
import 'package:mediaheds/ui/quiz.dart';

import 'package:mediaheds/ui/login.dart';
import 'package:mediaheds/state_container.dart';
import 'package:mediaheds/ui/home.dart';
import 'package:mediaheds/ui/quizMedia.dart';
import 'package:mediaheds/ui/quizSite.dart';
import 'package:mediaheds/ui/quizCatalogue.dart';
import 'package:mediaheds/ui/result.dart';

void main() => runApp(StateContainer(child: MyApp()));


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView(),
      routes: {
        '/login': (context) => LoginView(),
        '/quiz': (context) => Quiz1(),
        '/home': (context) => Home(),
        '/quizM': (context) => QuizM(),
        '/quizS': (context) => QuizS(),
        '/quizC': (context) => QuizC(),
        '/result': (context) => Result(),


      },

    );
  }
}


