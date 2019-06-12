import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediaheds/widets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:mediaheds/state_container.dart";
import "package:mediaheds/models/user.dart";

class Result extends StatefulWidget {
  final Widget child;

  Result({Key key, this.child}) : super(key: key);

  ResultState createState() => ResultState();
}

String scoreC = "0.0";
String scoreM = "0.0";
String scoreS = "0.0";
double scoreF = 0.0;

String gameC = "f";
String gameM = "f";
String gameS = "f";
double scoreactuel;

Future getRechercheCatalogueScore(BuildContext context) async {
  final container = StateContainer.of(context);

  User user = container.user;
  int scoreT = 0;
  int nbQ = 0;

  QuerySnapshot querySnapshot = await Firestore.instance
      .collection("user-type")
      .document(user.uid)
      .collection("quiz")
      .getDocuments();
  var list = querySnapshot.documents;

  for (var i = 0; i < list.length; i++) {
    if (list[i].data['quiz'].toString() == "Recherche Catalogue") {
      int val = int.parse(list[i].data['score'].toString());
      scoreT = scoreT + val;
      nbQ++;
    }
  }
  double scoreF = scoreT / nbQ;

  return scoreF.toString();
}

Future getRechercheMediaScore(BuildContext context) async {
  final container = StateContainer.of(context);

  User user = container.user;
  int scoreT = 0;
  int nbQ = 0;

  QuerySnapshot querySnapshot = await Firestore.instance
      .collection("user-type")
      .document(user.uid)
      .collection("quiz")
      .getDocuments();
  var list = querySnapshot.documents;

  for (var i = 0; i < list.length; i++) {
    if (list[i].data['quiz'].toString() == "Recherche Médiathèque") {
      int val = int.parse(list[i].data['score'].toString());
      scoreT = scoreT + val;
      nbQ++;
    }
  }
  double scoreF = scoreT / nbQ;

  return scoreF.toString();
}

Future getRechercheSiteScore(BuildContext context) async {
  final container = StateContainer.of(context);

  User user = container.user;
  int scoreT = 0;
  int nbQ = 0;

  QuerySnapshot querySnapshot = await Firestore.instance
      .collection("user-type")
      .document(user.uid)
      .collection("quiz")
      .getDocuments();
  var list = querySnapshot.documents;

  for (var i = 0; i < list.length; i++) {
    if (list[i].data['quiz'].toString() == "Condition Site") {
      int val = int.parse(list[i].data['score'].toString());
      scoreT = scoreT + val;
      nbQ++;
    }
  }
  double scoreF = scoreT / nbQ;

  return scoreF.toString();
}

Future getRechercheCatalogueG(BuildContext context) async {
  final container = StateContainer.of(context);

  User user = container.user;
  int scoreT = 0;
  int nbQ = 0;

  QuerySnapshot querySnapshot = await Firestore.instance
      .collection("user-type")
      .document(user.uid)
      .collection("quiz")
      .getDocuments();
  var list = querySnapshot.documents;

  for (var i = 0; i < list.length; i++) {
    if (list[i].data['quiz'].toString() == "Recherche Catalogue") {
      nbQ++;
    }
  }

  return nbQ.toString();
}

Future getRechercheMediaG(BuildContext context) async {
  final container = StateContainer.of(context);

  User user = container.user;
  int nbQ = 0;

  QuerySnapshot querySnapshot = await Firestore.instance
      .collection("user-type")
      .document(user.uid)
      .collection("quiz")
      .getDocuments();
  var list = querySnapshot.documents;

  for (var i = 0; i < list.length; i++) {
    if (list[i].data['quiz'].toString() == "Recherche Médiathèque") {
      nbQ++;
    }
  }

  return nbQ.toString();
}

Future getRechercheSiteG(BuildContext context) async {
  final container = StateContainer.of(context);

  User user = container.user;
  int nbQ = 0;

  QuerySnapshot querySnapshot = await Firestore.instance
      .collection("user-type")
      .document(user.uid)
      .collection("quiz")
      .getDocuments();
  var list = querySnapshot.documents;

  for (var i = 0; i < list.length; i++) {
    if (list[i].data['quiz'].toString() == "Condition Site") {
      nbQ++;
    }
  }

  return nbQ.toString();
}

class ResultState extends State<Result> {
  String textRDV = "";
  DateTime rdv = DateTime.now();
  TextEditingController infoRDV = TextEditingController();

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
      color: Colors.yellow,
    );
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    User user = container.user;

    // retrieve score
    getRechercheCatalogueScore(context).then((value) {

      setState(() {
        scoreC = value;
      });
    }).catchError((error) {
      print('Error');
    });

    getRechercheMediaScore(context).then((value) {


      setState(() {
        scoreM = value;

      });
    }).catchError((error) {
      print('Error');
    });

    getRechercheSiteScore(context).then((value) {
      setState(() {
        scoreS = value;

      });
    }).catchError((error) {
      print('Error');
    });

    // retrieveTotalGame
    getRechercheCatalogueG(context).then((value) {
      setState(() {
        gameC = value;
      });
    }).catchError((error) {
      print('Error');
    });

    getRechercheMediaG(context).then((value) {
      setState(() {
        gameM = value;
      });
    }).catchError((error) {
      print('Error');
    });

    getRechercheSiteG(context).then((value) {
      setState(() {
        gameS = value;
      });
    }).catchError((error) {
      print('Error');
    });

    setState(() {
      var onePointOne = double.parse(scoreC);
      var onePointOne1 = double.parse(scoreM);
      var onePointOne2 = double.parse(scoreS);
      scoreactuel = (onePointOne + onePointOne1 + onePointOne2);
    });

    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(

            title: Text('Vos résultats'),
            backgroundColor: Colors.white12,
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Container(
          margin: EdgeInsets.all(12.00),
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(color: Color(0xffffffff)),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                " Les résultats...",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 39),
              ),
              new Padding(padding: EdgeInsets.all(12.0)),
              new Container(
                decoration: myBoxDecoration(),
                child: Text(
                  "Voici les résultas aux différents quiz que vous avez fait : ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Column(
                children: <Widget>[
                  new Text(
                      "Votre score moyen pour le quiz 'Recherches via catalogue' est de " +
                          scoreC +
                          " / 13 en " +
                          gameC +
                          " essai(s)."),
                ],
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text(
                  "Score moyen pour le quiz 'Recherche bibliothèque' est de " +
                      scoreM +
                      " / 7 en " +
                      gameM +
                      " essai(s)."),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text("Score moyen pour le quiz 'Condition du site' est de " +
                  scoreS +
                  " / 15 en " +
                  gameS +
                  " essai(s)."),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text("Votre score moyen actuel : " + scoreactuel.toString()),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text(
                "Vous avez jusqu'à la fin du semestre pour arriver à un score moyen final de 25 pts. Vous devez réaliser au minimum 2 essais par quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
        ),
      ),
    );
  }
}
