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

    "Quel est le numéro de la revue Soins de 2011 qui parle spécialement des plaies ?",
    "Que signifie l’étiquette de cote rouge sur les livres ?",
    "Qui est l'auteur du travail de bachelor ayant la cote TB/SI/319 ?",
    "Quel est le titre du document : DVD/417 ?",
    "Quel est le titre du document : 615.851.7 BAU ?",
    "A quoi correspond les lettres BAU de la cote 615.851.7 BAU ?",
    "Sous quelles cotes trouve-t-on des livres de psychiatrie ?",
  ];

  var correct = [
    //answer 1
    [0],
    [1],
    [0],
    [0],
    [0],
    [2],
    [1],
  ];

  var choices = [
    //answer 1
    [
      "752",
      "755",
      "762",
      "753",
    ],

    //answer 2
    [
      "Livre important",
      "En consultation sur place",
      "Livre réservé",
      "Séminaire",
    ],

    //answer 3
    [
      "Le Bohec, Estelle",
      "Saugy, Célie",
      "Almeida Dos Santos, Christelle",
      "Dupont, Xavier",
    ],

    //answer 4
    [
      "Chroniques de la douleur",
      "Accouchement naturel, le grand retour",
      "Être avec",
      "Patients",
    ],

    //answer 5
    [
      "Animaux guérisseurs : l'énergie et le dévouement animal au service de l'homme",
      "Les animaux guérisseurs",
      "Zoothérapie : le pouvoir thérapeutique des animaux",
      "Zoothérapie une approche novatrice",
    ],

    //answer 6
    [
      "Aucune idée",
      "A la thématique du livre",
      "Au 3 premières lettres du nom de l'auteur",
      "Au 3 premières lettres du prénom de l'auteur ",
    ],

    //answer 7
    [
      "618",
      "616,89",
      "42",
      "Pas de livre sur cette thématique ",
    ],
  ];
}

class QuizM extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuizMState();
  }
}

class QuizMState extends State<QuizM> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Quiz : Recherche bibliothèque',
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

    if (questionNumber == 6) {
      Firestore.instance
          .collection("user-type")
          .document(user.uid)
          .collection("quiz")
          .add({
        "quiz": "Recherche Médiathèque",
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
              'Quiz : Recherche bibliothèque',
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
                    "Bravo, vous avez terminé le quiz sur la recherche en bibliothèque",
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
