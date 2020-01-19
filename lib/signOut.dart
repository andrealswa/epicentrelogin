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
          title: Text('EPICentre & Makers Space Login'),
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
            Text('This is the Sign Out'),
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
        color: Colors.lightBlue,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(record.name),
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
