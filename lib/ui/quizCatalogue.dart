import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:mediaheds/state_container.dart";
import "package:mediaheds/models/user.dart";

var scoreQ = 0;
var scoref = 0;

var questionNumber = 0;

var quiz = new Quizz();

class Quizz {
  var questions = [
    //  "Un animal s’approche de vous...",

    "Je recherche le livre : « Le praticien réflexif : à la recherche du savoir caché dans l'agir professionnel / Donald A. Schön ». Quelle est la cote de l’ouvrage de la HES-SO santé Sion?",
    "L'ouvrage de la Médiathèque santé « Le praticien réflexif : à la recherche du savoir caché dans l'agir professionnel / Donald A. Schön » est-il disponible pour le prêt?",
    "Quelle est le nom de la revue qui propose l'article suivant : Adapting the care pathway?",
    "En quelle année a été publié l'article suivant : Adapting the care pathway?",
    "Est-ce possible d'avoir accès au texte intégral du travail de bachelor en soins infirmiers : 'Entre professionnalisation et professionnalité en Suisse et en Belgique' / Myriam Graber, Véronique Haberey-Knuessi?",

    "Combien de films sur la thématique du cancer possède la bibliothèque de la HES-SO santé Sion ? ",
    "Combien de bibliothèques valaisannes possèdent le DVD  « Patients » de Grand Corps Malade?",
    "Puis-je commander un exemplaire de la Médiathèque de Saint-Maurice et le faire venir à la Médiathèque santé ?",
    "Puis-je rendre ce même DVD à la Médiathèque de Martigny si cela m’arrange ou faut-il le ramener à la Médiathèque santé obligatoirement ?",
    "Quelles sont les possibilités pour prolonger un document ? (plusieurs possibilités)",

    "Je recherche des travaux de Bachelor sur les chutes des personnes âgées, Existe-t-il un moyen de filtrer mes recherches pour obtenir uniquement des écrits académiques?",
    "Quelle bibliothèque possède le document « D'autres limites à la prison : comment l'art-thérapie peut aider à supporter le monde carcéral » de Girardin-Gantier, Odile?",
    "Quelle est la cote de l'ouvrage : L'avenir des silver tech : conception, usage et évaluation de Michel Hervé?",
  ];

  var correct = [
    //answer 1
    [0],
    [1],
    [2],
    [3],
    [0],

    [0],
    [1],
    [0],
    [0],
    [3],

    [1],
    [2],
    [3],
  ];

  var choices = [
    //answer 1
    [
      "371.2 SCH ",
      "377 SCH",
      "37.013 SCH ",
      "37 SCH",
    ],

    //answer 2
    [
      "oui",
      "non",
      "-",
      "-",
    ],

    //answer 3
    [
      "Soins. Cadres",
      "Soins",
      "Soins. Gerontologie",
      "Soins. Psychiatrie",
    ],

    //answer 4
    [
      "2016",
      "2017",
      "2018",
      "2019",
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
      "36",
      "342",
      "116",
      "54",
    ],

    //answer 7
    [
      "11",
      "6",
      "2",
      "8",
    ],

    //answer 8
    [
      "oui",
      "non",
      "-",
      "-",
    ],

    //answer 9
    [
      "Oui",
      "Non",
      "-",
      "-",
    ],

    //answer 10
    [
      "Appeler ou passer à la bibliothèque",
      "Envoyer un e-mail",
      "Prolonger via le catalogue",
      "Les trois réponses",
    ],

    //answer 11
    [
      "Non il n'existe pas de moyen",
      "Filtrer la recheche avec un filtre 'Thèses et Écrits Académiques'",
      "Ecrire mémoire dans la barre de recherche",
      "Ecrire bachelor dans la barre de recherche",
    ],

    //answer 12
    [
      "Sion - HES-SO",
      "Sion - Médiathèque Valais",
      "GE HETS : livres ",
      "-",
    ],

    //answer 13
    [
      "484 HERV",
      "484 AVE",
      "485 HERV",
      "484 AVE",
    ],
  ];
}

class QuizC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuizMState();
  }
}

class QuizMState extends State<QuizC> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Quiz : Recherche via catalogue',
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
    scoreQ = 0;
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
    if (questionNumber == 12) {
      Firestore.instance
          .collection("user-type")
          .document(user.uid)
          .collection("quiz")
          .add({
        "quiz": "Recherche Catalogue",
        "score": scoref,
        "date": now,
      });
      questionNumber = 0;
    }

    void resetQuiz() {
      scoreQ = 0;
      questionNumber = 0;
    }

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Quiz : Recherche via catalogue',
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
                    "Bravo, vous avez terminé le quiz sur la recherche via catalogue.",
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center),
              ),

              new Padding(padding: EdgeInsets.all(30.0)),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                child: new Text("Vous avez répondu juste a $scoref questions",
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
