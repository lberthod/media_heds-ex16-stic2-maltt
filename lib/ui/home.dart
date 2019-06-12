import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediaheds/widets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:mediaheds/state_container.dart";
import "package:mediaheds/models/user.dart";

class Home extends StatefulWidget {
  final Widget child;

  Home({Key key, this.child}) : super(key: key);

  AgendaState createState() => AgendaState();
}

class AgendaState extends State<Home> {
  String textRDV = "";
  DateTime rdv = DateTime.now();
  TextEditingController infoRDV = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    User user = container.user;

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Container with scaffold',
      home: Scaffold(
        body: Container(
          // color: Colors.blue,
          height: double.infinity,
          // provides unbounded height constraints for the child container
          width: double.infinity,
          // provides unbounded width constraints for the child container

          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(8.0)),

              new Container(
                color: Colors.yellow,
                child: Image.asset('assets/media.png'),
                width: 150,
              ),

              new Container(
                color: Colors.yellow,
                child: Image.asset('assets/heds.png'),
                width: 150,
              ),

              new Padding(padding: EdgeInsets.all(8.0)),

              new Container(
                margin: EdgeInsets.all(15.00),
                child: new Text(
                  "Bienvenu dans l'application d'exercices pour le cours de la médiathèque. Veuillez faire les quizz ci-dessous.",
                  textAlign: TextAlign.center,
                ),
              ),

              new MaterialButton(
                  height: 50.0,
                  color: Colors.yellow,
                  onPressed: () {
                    Navigator.pushNamed(context, '/quizS');
                  },
                  child: new Text(
                    "Quiz : Condition Site",
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  )),
              new Padding(padding: EdgeInsets.all(8.0)),
              //

              new MaterialButton(
                  height: 50.0,
                  color: Colors.yellow,
                  onPressed: () {
                    Navigator.pushNamed(context, '/quizM');
                  },
                  child: new Text(
                    "Quiz : Recherche bibliothèque",
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  )),
              new Padding(padding: EdgeInsets.all(8.0)),
              new MaterialButton(
                  height: 50.0,
                  color: Colors.yellow,
                  onPressed: () {
                    Navigator.pushNamed(context, '/quizC');
                  },
                  child: new Text(
                    "Quiz : Recherche via catalogue",
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  )),
              new Padding(padding: EdgeInsets.all(8.0)),

              new MaterialButton(
                  height: 50.0,
                  color: Colors.yellow,
                  onPressed: () {
                    Navigator.pushNamed(context, '/result');
                  },
                  child: new Text(
                    "Vos résultats",
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  )),

              new Padding(padding: EdgeInsets.all(8.0)),
              new Text(
                "Application créée par Loïc Berthod, étudiant au MALTT comme exercice 16 de STIC-2",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
