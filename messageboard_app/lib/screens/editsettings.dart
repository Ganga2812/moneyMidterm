import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messageboard_app/screens/home.dart';
import 'package:messageboard_app/screens/profile.dart';
import 'package:messageboard_app/screens/wrapper.dart';
import 'package:messageboard_app/services/auth.dart';
import 'package:messageboard_app/services/database.dart';

class EditSettings extends StatefulWidget {
  EditSettings({Key? key}) : super(key: key);

  @override
  _EditSettingsState createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  late String social;
  String password = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController socialController = TextEditingController();

  void _changePassword(String password) async {
    User? user = await FirebaseAuth.instance.currentUser;

    user!.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }

  Column buildPasswordField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Enter new password.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextField(
            controller: passwordController,
          ),
        ]);
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Column buildSocialField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Enter your social media handles",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextFormField(
            controller: socialController,
            onChanged: (value) {
              social = value;
            },
          ),
        ]);
  }

  Future<void> addSocial(social_media) {
    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return users
        .doc(uid)
        .update({
          'social': social_media,
        })
        .then((value) => print("Social Added"))
        .catchError((error) => print("Failed to add social: $error"));
  }

  Widget socialButton() {
    return FlatButton(
      child: Text("Update Social Medias"),
      onPressed: () {
        print(socialController);
        //Navigator.pop(context,[social]);
        addSocial(social);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Edit Settings'),
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
          ],
        ),
      ),
      body: ListView(children: <Widget>[
        Container(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  buildPasswordField(),
                ],
              ),
            ),
            RaisedButton(
                onPressed: () {
                  _changePassword(passwordController.text);
                },
                child: Text("Update password")),
            cancelButton(),
            buildSocialField(),
            socialButton(),
          ],
        ))
      ]),
    );
  }
}
