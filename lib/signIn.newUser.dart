import 'package:flutter/material.dart';

class newUser extends StatefulWidget {
  newUser({Key key}) : super(key: key);

  @override
  _newUserState createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color(0xff6da9c9),
              Color(0xff6da9c9),
              Color(0xffb7d5dd),
              Color(0xffb7d5dd),
            ],
          ),
        ),
        child: Scaffold(
            backgroundColor: Color(0x00000000),
            appBar: AppBar(
              title: Text('EPICentre & Makers Space Login - New Visitor'),
              flexibleSpace: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF00CCFF),
                        const Color(0xFF3366FF),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
            ),
            body: Text("newUser Page")),
      ),
    );
  }
}
