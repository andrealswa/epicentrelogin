import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            Spacer(flex: 2),
            Text('Enter Your Name'),
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
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Submit Your Name'),
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
    stream: Firestore.instance.collection('guests').snapshots(),
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
        onTap: () => record.reference.updateData(
          {'visits': FieldValue.increment(1)},
        ),
      ),
    ),
  );
}

class Record {
  final String name;
  final int visits;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['visits'] != null),
        name = map['name'],
        visits = map['visits'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data,
          reference: snapshot.reference,
        );

  @override
  String toString() => "Record<$name:$visits>";
}
