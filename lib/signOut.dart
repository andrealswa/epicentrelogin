import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignOut extends StatefulWidget {
  SignOut({Key key}) : super(key: key);

  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color(0XFFfbc4a0),
            Color(0XFFfbc4a0),
            Color(0XFFd28d84),
            Color(0XFFd28d84),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0x00000000),
        appBar: AppBar(
          title: Text('Guest Sign Out'),
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
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      children: <Widget>[
                        GradientText(
                          'Tap Your Name to Sign Out',
                          gradient: LinearGradient(colors: [
                            Color(0xfff6834c),
                            Color(0xfff66277),
                            Color(0xffec4998),
                          ]),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
        .where('signedIn', isEqualTo: true)
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
        color: Color(0xffefefef),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.touch_app,
                color: Colors.grey,
                size: 35.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
            Text('Tap to Sign Out'),
            SizedBox(width: 25),
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
