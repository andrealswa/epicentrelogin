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
          title: Text('EPICentre & Makers Space Login - Returning Visitor'),
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
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      children: <Widget>[
                        GradientText(
                          'First Time Visiting? Click Here To Enter Your Info',
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
            Spacer(flex: 2),
            Text('Search For Your Name'),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Add TextFormFields and RaisedButton here.
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Expanded(flex: 3, child: _buildBody(context)),
            Spacer(flex: 3),
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
    key: ValueKey(record.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.touch_app,
              color: Colors.white,
              size: 35.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text("Sign In"),
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
