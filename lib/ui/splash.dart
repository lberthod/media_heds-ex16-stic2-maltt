import 'package:flutter/material.dart';
import 'package:mediaheds/utils.dart';
import 'package:mediaheds/state_container.dart';
import 'package:mediaheds/ui/chat-screen.dart';

class SpashScreen extends StatefulWidget {
  final Widget child;

  SpashScreen({Key key, this.child}) : super(key: key);

  _SpashScreenState createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    new Future.delayed(new Duration(seconds: 1)).then((_) {
      AuthUtil.getUserId().then((userId) => handleNavigation(userId));
    });
    super.initState();
  }

  handleNavigation(userId) {
    if (userId == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      StateContainer.of(context).updateUserInfo(uid: userId);
       Navigator.pushReplacementNamed(context, '/agenda');

    //   Navigator.pushReplacement (
    //       context,
    //       new MaterialPageRoute(
    //           builder: (BuildContext context) => new ChatScreen(
    //                 uid: userId,
    //               )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          child: CircularProgressIndicator(
            strokeWidth: 15.0,
          ),
        ),
      ),
    );
  }
}
