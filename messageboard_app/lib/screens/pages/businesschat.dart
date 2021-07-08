import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messageboard_app/models/user.dart';
import 'package:messageboard_app/screens/home.dart';
import 'package:messageboard_app/screens/pages/chats/businesschat.dart';
import 'package:messageboard_app/screens/pages/chats/gameschat.dart';
import 'package:messageboard_app/screens/setting.dart';
import 'package:messageboard_app/screens/wrapper.dart';
import 'package:messageboard_app/services/auth.dart';
import 'package:messageboard_app/services/database.dart';
import 'package:messageboard_app/shared/constants.dart';
import 'package:messageboard_app/widgets/message_tile.dart';
import 'package:provider/provider.dart';

import '../profile.dart';

class BusinessChatPage extends StatefulWidget {
  @override
  _BusinessChatPageState createState() => _BusinessChatPageState();
}

class _BusinessChatPageState extends State<BusinessChatPage> {
  final AuthService _auth = AuthService();

  String input = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  User user = FirebaseAuth.instance.currentUser!;
  String username = '';

  @override
  Widget build(BuildContext context) {
    getUserName(user.uid);

    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Business Group'),
        backgroundColor: Color(0xFF2a9d8f),
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            CustomListTile(Icons.backpack, 'Message Boards', () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Wrapper()));
            }),
            CustomListTile(Icons.person, 'Profile', () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Profile()));
            }),
            CustomListTile(Icons.settings, 'Settings', () {
              //await _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Setting()));
            }),
            CustomListTile(Icons.logout, 'Log Out', () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Wrapper()));
            }),
          ],
        ),
      ),
      body: Container(
          child: Stack(children: <Widget>[
        // getUserName(user.uid),
        BusinessList(),
        Container(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                    onChanged: (value) {
                      input = value;
                    },
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Message')),
              ),
              SizedBox(width: 12.0),
              GestureDetector(
                onTap: () async {
                  await _auth.postBusiness(
                      username, input, DateTime.now().toString());
                },
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                      color: Color(0xFF2a9d8f),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(child: Icon(Icons.send, color: Colors.white)),
                ),
              )
            ],
          ),
        )
      ])),
    );
  }

  void getUserName(documentId) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users.doc(documentId).get().then((DocumentSnapshot documentSnapshot) {
      setState(() => username = documentSnapshot.get('Full Name'));
    });
  }
}

void _errorPost(context) {
  showDialog(
    context: context,
    builder: (BuildContext bc) {
      return AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ALERT',
              style: TextStyle(
                  color: Color(0xFFe76f51),
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ],
        ),
        content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Content Required',
                style: TextStyle(
                    color: Color(0xFFe76f51),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                padding: EdgeInsets.all(8),
                minWidth: 180,
                color: Color(0xFF2a9d8f),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              )
            ]),
      );
    },
  );
}
