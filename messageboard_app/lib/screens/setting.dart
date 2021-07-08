import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messageboard_app/screens/authenticate/authentication.dart';
import 'package:messageboard_app/screens/editprofile.dart';
import 'package:messageboard_app/screens/home.dart';
import 'package:messageboard_app/screens/profile.dart';
import 'package:messageboard_app/screens/wrapper.dart';
import 'package:messageboard_app/services/auth.dart';

import 'authenticate/sign_in.dart';
import 'editsettings.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final AuthService _auth = AuthService();
  String? email;
  String? password;
  String? social;

  getLastName() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // return Text("${data['Full Name']}", style: TextStyle(fontSize: 17.0));
          return Text("${data['social']}", style: TextStyle(fontSize: 17.0));
        }

        return Text("loading");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Settings'),
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
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 170.0),
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.account_circle, size: 200.0, color: Colors.white),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Change your password',
                          style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                  Divider(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Password', style: TextStyle(fontSize: 17.0)),
                      Text('********', style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                  Divider(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Update Social Media',
                          style: TextStyle(fontSize: 17.0)),
                    ],
                  ),
                  getLastName(),
                ],
              ),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final List<String> pageResults = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditSettings()));
          setState(() {
            social = pageResults[0];
          });
        },
        child: Icon(Icons.edit, color: Colors.white, size: 30.0),
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
      ),
    );
  }
}
