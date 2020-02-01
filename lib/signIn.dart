import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signIn.newUser.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to changes to the text form field.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  String _testName = "";

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
            Color(0xff6da9c9),
            Color(0xffb7d5dd),
            Color(0xffb7d5dd),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0x00000000),
        appBar: AppBar(
          title: Text('Returning Guest Sign In'),
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
        body: Column(
          children: <Widget>[
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
                      builder: (context) => newUser(),
                    );
                    Navigator.push(context, route);
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      children: <Widget>[
                        GradientText(
                          'New Guest',
                          gradient: LinearGradient(colors: [
                            Color(0xff3cc3fa),
                            Color(0xff42c9a5),
                            Color(0xff4bda3c),
                          ]),
                        ),
                        Spacer(),
                        Icon(
                          Icons.edit,
                          color: Color(0xff4bda3c),
                          size: 35.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              child: Text(
                'Search for Your Name',
                style: TextStyle(
                  fontSize: 25.0, // insert your font size here
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextField(
                controller: myController,
                onChanged: (text) {
                  setState(() {
                    this._testName = text;
                  });
                  final alphanumeric =
                      RegExp(r'^' + r'' + this._testName + r'$');
                  print(alphanumeric.hasMatch('abc123')); // true
                  print(alphanumeric.hasMatch('abc123%')); // false
                },
              ),
            ),
            Text(this._testName),
            Expanded(flex: 3, child: _buildBody(context)),
          ],
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('guests')
        .where('signedIn', isEqualTo: false)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  return Padding(
    key: ValueKey(record.hashCode),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xffefefef),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.touch_app,
              color: Colors.grey,
              size: 35.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text("Tap to Sign In"),
            SizedBox(width: 20), // give it width
            Text(record.name),
          ],
        ),
        trailing: Text(record.visits.toString()),
        onTap: () {
          if (record.signedIn == true) {
            record.reference.updateData({'signedIn': false});
          } else if (record.signedIn == false) {
            record.reference.updateData({'signedIn': true});
          }
          record.reference.updateData({'visits': FieldValue.increment(1)});
        },
      ),
    ),
  );
}

class Record {
  final String name;
  final int visits;
  final DocumentReference reference;
  final bool signedIn;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['visits'] != null),
        assert(map['signedIn'] != null),
        name = map['name'],
        visits = map['visits'],
        signedIn = map['signedIn'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data,
          reference: snapshot.reference,
        );

  @override
  String toString() => "Record<$name:$visits:$signedIn>";
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
          fontSize: 30,
        ),
      ),
    );
  }
}
