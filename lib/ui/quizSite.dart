import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:mediaheds/state_container.dart";
import "package:mediaheds/models/user.dart";

var scoref = 0;

var questionNumber = 0;

var quiz = new Quizz();

class Quizz {
  var questions = [
    //  "Un animal s’approche de vous...",

    "Qui peut venir emprunter des documents à la Médiathèque santé ?",
    "Combien de prêts peuvent emprunter les étudiants?",
    "Quelle est la durée de prêt pour les livres, les DVD, les revues",
    "Combien de fois peut-on prolonger un document?",
    "Peut-on prolonger un document s’il est demandé par quelqu’un ?",

    "A combien se monte les frais de rappel à la Médiathèque santé?",
    "Combien coûte un prêt entre bibliothèques si on fait venir un document hors du Valais ?",
    "Comment s’appelle le catalogue de la Médiathèque santé qui permet de rechercher, de réserver les documents de la bibliothèque et des bibliothèques partenaires ?",
    "Quel est le nom de la plateforme sur laquelle on trouve le texte intégral des travaux de bachelor en soins infirmiers?",
    "Qu’est-ce que la norme APA  (American psychological association) ?",

    "Quel est le nom du logiciel qui est utilisé pour gérer et automatiser l’insertion des références bibliographiques dans son travail?",
    "Je souhaite me former moi-même à l’utilisation de ce logiciel, des outils sont-ils proposés sur le site de la Médiathèque santé ?",
    "Quel site nous donne des informations sous forme de petites capsules vidéos par rapport au plagiat, à la recherche documentaire… ?",
    "Sous quelle forme puis-je accéder à la revue « Soins Cadres » ?",
    "Je souhaite trouver un article du journal le Temps d’aujourd’hui. Quelle(s) plateforme(s) puis-je utiliser ?"
        "Je recherche un e-book sur le sketchnote, sur quelle palteforme vais-je le trouver?"
        "Je recherche un e-book sur le sketchnote, sur quelle palteforme vais-je le trouver?"
  ];

  var correct = [
    //answer 1
    [0],
    [2],
    [1],
    [1],
    [1],

    [0],
    [3],
    [1],
    [0],
    [3],

    [1],
    [0],
    [0],
    [1],
    [1],
    [2],
  ];

  var choices = [
    //answer 1
    [
      "Tout le monde",
      "Les étudiants et professeurs/chercheurs",
      "Toute personne travaillant dans le domaine de la santé",
      "-",
    ],

    //answer 2
    [
      "5",
      "10",
      "20",
      "illimité",
    ],

    //answer 3
    [
      "Livres/ DVD/revues : 28 jours",
      "Livres/ DVD : 28 jours, revues : 14 jours ",
      "Livres/ DVD/revues : 14 jours ",
      "Livres/ DVD : 14 jours, revues : 28jours ",
    ],

    //answer 4
    [
      "3",
      "5",
      "pas de prolongation possible",
      "prolongations illimités",
    ],

    //answer 5
    [
      "oui",
      "non",
      "-",
      "-",
    ],

    //answer 6
    [
      "10 ct par jour et par document",
      "20 ct par jour et par document",
      "50 ct par jour et par document",
      "pas de frais de rappel",
    ],

    //answer 7
    [
      "3.-",
      "5.-",
      "gratuit",
      "gratuit durant la période des études ",
    ],

    //answer 8
    [
      "Nebis",
      "RERO Explore",
      "Rero Doc",
      "Swissbib",
    ],

    //answer 9
    [
      "Rero DOC",
      "RERO Explore",
      "ScholarVox",
      "Cinahl",
    ],

    //answer 10
    [
      "Règle de classement des livres",
      "Règle d'archivage des TB",
      "Règle de mise en page des TB",
      "Règles de base de rédaction d'une bibliographie",
    ],

    //answer 11
    [
      "Cerise",
      "Zotero",
      "-",
      "-",
    ],

    //answer 12
    [
      "vidéos, tutoriel papier",
      "tutoriel papier, podcast audio",
      "powerpoint, vidéos",
      "Pas  d'aide sur ce sujet",
    ],

    //answer 13
    [
      "Infosphère",
      "MonDiapason",
      "Cerise",
      "Infotrack",
    ],

    //answer 14
    [
      "papier",
      "papier et électronique",
      "électronique",
      "-",
    ],

    //answer 15
    [
      "Explore RERO",
      "Swissdox",
      "Cairn",
      "Medline",
    ],

    //answer 15
    [
      "Explore RERO",
      "Cairn",
      "ScholarVox",
      "Cinahl",
    ],
  ];
}

class QuizS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuizMState();
  }
}

class QuizMState extends State<QuizS> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Quiz : Condition du site',
                style: TextStyle(fontSize: 15),
              ),
              backgroundColor: Colors.white12,
              leading: IconButton(
                icon: Icon(Icons.home),
                onPressed: () => Navigator.pop(context, false),
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.all(12.0)),
                new Container(
                  alignment: Alignment.center,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 20.0),
                        child: new Text(
                          "Question ${questionNumber + 1} sur ${quiz.questions.length}",
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                new Padding(padding: EdgeInsets.all(10.10)),
                new Container(
                  padding: EdgeInsets.all(12.00),
                  decoration: myBoxDecoration(),
                  child: new Text(
                    "Répondez à la question en cliquant sur le bouton adéquat",
                    style: new TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 20.0),
                  child: new Text(
                    "Question : " + quiz.questions[questionNumber],
                    style: new TextStyle(
                        fontSize: 16.0,
                        decorationColor: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new FlatButton(
                  onPressed: () {
                    if (quiz.choices[questionNumber][0] ==
                        quiz.choices[questionNumber]
                        [quiz.correct[questionNumber][0]]) {
                      scoref++;
                    }
                    updateQuestion();
                  },
                  child: new Text(
                    quiz.choices[questionNumber][0],
                    style: new TextStyle(fontSize: 22.0, color: Colors.black87),
                  ),
                  color: Colors.yellow,
                  textTheme: ButtonTextTheme.accent,
                ),
                new Padding(padding: EdgeInsets.all(10.10)),
                new FlatButton(
                  onPressed: () {
                    if (quiz.choices[questionNumber][0] ==
                        quiz.choices[questionNumber]
                        [quiz.correct[questionNumber][0]]) {
                      scoref++;
                    }
                    updateQuestion();
                  },
                  child: new Text(
                    quiz.choices[questionNumber][1],
                    style: new TextStyle(fontSize: 22.0, color: Colors.black87),
                  ),
                  color: Colors.yellow,
                  textTheme: ButtonTextTheme.accent,
                ),
                new Padding(padding: EdgeInsets.all(10.10)),
                new FlatButton(
                  onPressed: () {
                    if (quiz.choices[questionNumber][0] ==
                        quiz.choices[questionNumber]
                        [quiz.correct[questionNumber][0]]) {
                      scoref++;
                    }
                    updateQuestion();
                  },
                  child: new Text(
                    quiz.choices[questionNumber][2],
                    style: new TextStyle(fontSize: 22.0, color: Colors.black87),
                  ),
                  color: Colors.yellow,
                  textTheme: ButtonTextTheme.accent,
                ),
                new Padding(padding: EdgeInsets.all(10.10)),
                new FlatButton(
                  onPressed: () {
                    if (quiz.choices[questionNumber][0] ==
                        quiz.choices[questionNumber]
                        [quiz.correct[questionNumber][0]]) {
                      scoref++;
                    }
                    updateQuestion();
                  },
                  child: new Text(
                    quiz.choices[questionNumber][3],
                    style: new TextStyle(fontSize: 22.0, color: Colors.black87),
                  ),
                  color: Colors.yellow,
                  textTheme: ButtonTextTheme.accent,
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
              ],
            ),
          ),
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
      color: Colors.yellow,
    );
  }

  void resetQuiz() {

    scoref = 0;
    questionNumber = 0;

    setState(() {
      Navigator.pushNamed(context, '/agenda');
    });
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.questions.length - 1) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Summary()));
      } else {
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget {
  final int score;
  var now = new DateTime.now();

  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    User user = container.user;
    if (questionNumber == 14) {
      Firestore.instance
          .collection("user-type")
          .document(user.uid)
          .collection("quiz")
          .add({
        "quiz": "Condition Site",
        "score": scoref,
        "date": now,
      });
      questionNumber = 0;
    }

    void resetQuiz() {
      scoref = 0;
      questionNumber = 0;
    }

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Quiz : Condition du site ',
              style: TextStyle(fontSize: 15),
            ),
            backgroundColor: Colors.white12,
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () => Navigator.pushNamed(context, '/home'),
            )),
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                child: new Text(
                    "Bravo, vous avez terminé le quiz sur les conditions du site.",
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center),
              ),

              new Padding(padding: EdgeInsets.all(30.0)),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                child: new Text("Vous avez répondu juste à $scoref questions",
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center),
              ),

              new Padding(padding: EdgeInsets.all(30.0)),

              new MaterialButton(
                color: Colors.yellow,
                onPressed: () {
                  scoref = 0;

                  Navigator.pop(context);
                },
                child: new Text(
                  "Recommencer le quiz?",
                  style: new TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
              ), //
              new Padding(padding: EdgeInsets.all(30.0)),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                child: new Text(
                    "Rappellez vous qu'il vous faut faire chaque quiz au minimum deux fois et avoir 25 points de moyenne générale. Pour recommencer cliquer sur le bouton, pour revenir à l'accueil appuez sur l'icône en haut à gauche.  ",
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
