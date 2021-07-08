import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messageboard_app/screens/home.dart';
import 'package:messageboard_app/screens/wrapper.dart';
import 'package:messageboard_app/services/auth.dart';
import 'package:messageboard_app/services/database.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  late String fname;
  late String lname;
  late String date;

  getUid() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    return uid;
  }

  getFirstName() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(getUid())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        fname = documentSnapshot.get('First Name');
      }
    });
  }

  getLastName() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(getUid())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        lname = documentSnapshot.get('Last Name');
      }
    });
  }

  getDate() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(getUid())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        date = documentSnapshot.get('Register Date');
      }
    });
  }

  updateProfileData() {
    var dbs = new DatabaseService(uid: getUid());
    setState(() {
      if (fnameController.text == "") {
        fnameController.text = fname;
      }
      if (lnameController.text == "") {
        lnameController.text = lname;
      }
      dbs.updateUserData(fnameController.text, lnameController.text, date);
      Navigator.pop(context, [fnameController.text, lnameController.text]);
    });
  }

  Column buildFirstName() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "First Name",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextField(
            controller: fnameController,
          ),
        ]);
  }

  Column buildLastName() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Last Name",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextField(
            controller: lnameController,
          ),
        ]);
  }

  Widget cancelButton() {
    getFirstName();
    getLastName();
    getDate();
    return FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context, [fname, lname]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF2a9d8f),
        elevation: 0.0,
      ),
      
      body: ListView(children: <Widget>[
        Container(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  buildFirstName(),
                  buildLastName(),
                ],
              ),
            ),
            RaisedButton(
                onPressed: () {
                  updateProfileData();
                },
                child: Text("Update Profile")),
            cancelButton(),
          ],
        ))
      ]),
    );
  }
}
