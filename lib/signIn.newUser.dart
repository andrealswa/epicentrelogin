import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:epicentrelogin/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class newUser extends StatefulWidget {
  newUser({Key key}) : super(key: key);

  @override
  _newUserState createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  // Guess this key is for data
  final _formKey = GlobalKey<FormState>();
  final double _fontSizeValue = 20.0;
  final _globalKey = GlobalKey<ScaffoldState>();
  String _globalFirstName = "";
  String _globalLastName = "";
  String _globalOrganization = "";
  String _globalEmail = "";
  String _globalPurpose = "";

  // Firebase instance object
  final databaseReference = Firestore.instance;

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
          key: _globalKey,
          backgroundColor: Color(0x00000000),
          appBar: AppBar(
            title: Text('New Guest'),
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Add TextFormFields and RaisedButton here.
//

                      TextFormField(
                        onChanged: (String value) async {
                          _globalFirstName = value;
                        },
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              print('tapped');
                            },
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          labelText: 'First Name *',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: _fontSizeValue,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _fontSizeValue,
                            fontFamily: 'AvenirLight'),
                        //  controller: _passwordController,
                      ),

//

                      TextFormField(
                        onChanged: (String value) async {
                          _globalLastName = value;
                        },
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              print('tapped');
                            },
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          labelText: 'Last Name *',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: _fontSizeValue,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _fontSizeValue,
                            fontFamily: 'AvenirLight'),
                        //  controller: _passwordController,
                      ),

                      //

                      TextFormField(
                        onChanged: (String value) async {
                          _globalOrganization = value;
                        },
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              print('tapped');
                            },
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          labelText: 'Organization',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: _fontSizeValue,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _fontSizeValue,
                            fontFamily: 'AvenirLight'),
                        //  controller: _passwordController,
                      ),

//

                      TextFormField(
                        onChanged: (String value) async {
                          _globalEmail = value;
                        },
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              print('tapped');
                            },
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: _fontSizeValue,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _fontSizeValue,
                            fontFamily: 'AvenirLight'),
                        //  controller: _passwordController,
                      ),

//

                      TextFormField(
                        onChanged: (String value) async {
                          _globalPurpose = value;
                        },
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              print('tapped');
                            },
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          labelText: 'Purpose of Visit',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: _fontSizeValue,
                              fontFamily: 'AvenirLight'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.5)),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: _fontSizeValue,
                            fontFamily: 'AvenirLight'),
                        //  controller: _passwordController,
                      ),

//

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: RaisedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.

                              // Do database queries here
                              void createRecord() async {
                                await databaseReference
                                    .collection("guests")
                                    .document() // Leave empty for firestore to autogenerate the document id
                                    .setData({
                                  'name':
                                      _globalFirstName + " " + _globalLastName,
                                  'organization': _globalOrganization,
                                  'email': _globalEmail,
                                  'purpose': _globalPurpose,
                                  'signedIn': true,
                                  'visits': 1,
                                });
                              }

                              createRecord();

                              final snackBar = SnackBar(
                                  content: Text(
                                      'Information Saved: You Have Been Signed In'));
                              _globalKey.currentState.showSnackBar(snackBar);

                              Alert(
                                context: context,
                                type: AlertType.success,
                                buttons: [],
                                title:
                                    "WELCOME ${_globalFirstName.toUpperCase() + " " + _globalLastName.toUpperCase()}",
                                desc: "You are now registered and signed in!",
                              ).show();

                              Future.delayed(const Duration(milliseconds: 2000),
                                  () {
                                Route route = MaterialPageRoute(
                                  builder: (context) => MyApp(),
                                );
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                              });
                            }
                          },
                          child: Text('Sign In'),
                        ),
                      ),

//
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
