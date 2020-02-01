import 'package:flutter/material.dart';
import 'signIn.dart';
import 'signOut.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'EPICentre & Makers Space Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color(0xff6da9c9),
            Color(0xffb7d5dd),
            Color(0XFFfbc4a0),
            Color(0XFFd28d84),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0x00000000),
        appBar: AppBar(
          title: Text(widget.title),
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
        body: Center(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Color(0xffefefef),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(50.0),
                              topRight: const Radius.circular(50.0)),
                          side: BorderSide(color: Color(0xffefefef))),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => SignIn(),
                        );
                        Navigator.push(context, route);
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: GradientText(
                          'Sign In',
                          gradient: LinearGradient(colors: [
                            Color(0xff3cc3fa),
                            Color(0xff42c9a5),
                            Color(0xff4bda3c),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                //End Sign In

                //Begin Grey bar divider

                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 30.0,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.5),
                          blurRadius: 1.5,
                        ),
                      ], color: Color(0xffdbdbdb)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Color(0xffefefef),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.only(
                              bottomLeft: const Radius.circular(50.0),
                              bottomRight: const Radius.circular(50.0)),
                          side: BorderSide(color: Color(0xffefefef))),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                          builder: (context) => SignOut(),
                        );
                        Navigator.push(context, route);
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: GradientText(
                          'Sign Out',
                          gradient: LinearGradient(colors: [
                            Color(0xfff6834c),
                            Color(0xfff66277),
                            Color(0xffec4998),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 100,
        ),
      ),
    );
  }
}
