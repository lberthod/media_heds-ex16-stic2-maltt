import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediaheds/utils.dart';
import 'package:mediaheds/widets.dart';
import 'package:mediaheds/state_container.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class LoginView extends StatefulWidget {
  final Widget child;

  LoginView({Key key, this.child}) : super(key: key);

  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _pageController = PageController(initialPage: 0);

  final _signInPageKey = GlobalKey<FormState>();
  bool _obscureTextSignIn = true;
  TextEditingController signInemailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  final _signUpPageKey = GlobalKey<FormState>();
  bool _obscureTextSignUp = true;
  TextEditingController signUpemailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();

  String _validateEmail(String value) {
    if (value.isEmpty) return 'Field is required';
    final RegExp nameExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) return 'Field is required';
    if (value.length < 4) return 'Minimum 4 characters';
    return null;
  }

  void _toggleSignInPassword() {
    setState(() {
      _obscureTextSignIn = !_obscureTextSignIn;
    });
  }

  void _toggleSignUpPassword() {
    setState(() {
      _obscureTextSignUp = !_obscureTextSignUp;
    });
  }

  void _login() async {
    FirebaseUser user = await AuthUtil.handleSignInEmail(
            signInemailController.text,
            signInPasswordController.text.toString())
        .then((FirebaseUser user) => user)
        .catchError((error) => WidgetUtils.displaySnackBar(
            _scaffoldKey.currentState, error.toString(), Colors.red));
    if (user != null)
      WidgetUtils.displaySnackBar(_scaffoldKey.currentState, "Logged in");
    StateContainer.of(context).updateUserInfo(uid: user.uid);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _register() async {
    FirebaseUser user = await AuthUtil.handleSignUp(signUpemailController.text,
            signUpPasswordController.text.toString())
        .then((FirebaseUser user) {
      return user;
    }).catchError((error) => WidgetUtils.displaySnackBar(
            _scaffoldKey.currentState, error, Colors.red));
    if (user != null) {
      Firestore.instance
          .collection('user-chat')
          .document(user.uid)
          .setData({'email': user.email});
      StateContainer.of(context).updateUserInfo(uid: user.uid);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Quiz - Médiathèque',
              style: TextStyle(fontSize: 15),
            ),
            backgroundColor: Colors.white12,
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                _buildSignInView(context),
                _buildSignUpView(context)
              ],
            ),
          )),
    );
  }

  Widget _buildSignInView(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Form(
                key: _signInPageKey,
                child: Card(
                    elevation: 2.0,
                    color: Colors.white12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      height: 200.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Merci de vous autentifier!",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          _buildTextField(
                              "Email",
                              "john@doe.com",
                              signInemailController,
                              _validateEmail,
                              Icon(Icons.alternate_email)),
                          _buildTextField(
                              'Mot de passe',
                              "Secret",
                              signInPasswordController,
                              _validatePassword,
                              Icon(Icons.lock_outline),
                              true,
                              _obscureTextSignIn,
                              _toggleSignInPassword),
                          RaisedButton(
                              color: Colors.yellow,
                              child: Text(
                                'Se connecter',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                if (_signInPageKey.currentState.validate()) {
                                  _login();
                                }
                              }),
                          Container(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                _pageController.animateToPage(1,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn);
                              },
                              child: Text(
                                "Pas de compte? Inscrivez-vous !",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))),
      ],
    );
  }

  Widget _buildSignUpView(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Form(
                key: _signUpPageKey,
                child: Card(
                  elevation: 2.0,
                  color: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    height: 200.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Inscrivez votre adresse e-mail et votre mot de passe.",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        _buildTextField(
                            "Email",
                            "john@doe.com",
                            signUpemailController,
                            _validateEmail,
                            Icon(Icons.alternate_email)),
                        _buildTextField(
                            'Mot de passe',
                            "Secret",
                            signUpPasswordController,
                            _validatePassword,
                            Icon(Icons.lock_outline),
                            true,
                            _obscureTextSignUp,
                            _toggleSignUpPassword),
                        RaisedButton(
                            color: Colors.yellow,
                            child: Text(
                              "S'inscrire",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              if (_signUpPageKey.currentState.validate()) {
                                _register();
                              }
                            }),
                        Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn);
                            },
                            child: Text(
                              "Vous avez déjà un compte?",
                              textDirection: TextDirection.ltr,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
      ],
    );
  }

  Widget _buildTextField(String label, String hint,
      TextEditingController textController, Function validator, Icon icon,
      [bool secure = false, bool isObscure = false, Function onSuffixTap]) {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Center(
              child: TextFormField(
                controller: textController,
                keyboardType: TextInputType.text,
                validator: validator,
                obscureText: isObscure,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    icon: icon,
                    hintText: hint,
                    labelText: label,
                    border: null,
                    errorStyle: TextStyle(height: 0.3),
                    suffix: secure
                        ? GestureDetector(
                            onTap: onSuffixTap,
                            child: Icon(
                              isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 30.0,
                            ),
                          )
                        : null),
              ),
            )));
  }
}
