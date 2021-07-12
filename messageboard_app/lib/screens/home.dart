import 'package:messageboard_app/screens/grouplist.dart';
import 'package:messageboard_app/screens/profile.dart';
import 'package:messageboard_app/screens/setting.dart';
import 'package:messageboard_app/screens/wrapper.dart';
import 'package:messageboard_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:messageboard_app/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);
  // Create instant object _auth
  final AuthService _auth = AuthService();
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Welcome! Select A Room'),
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
      body: GroupList(),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  
  

  CustomListTile(this.icon, this.text, this.onTap);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Color(0x882a9d8f),
          )),
        ),
        child: ListTile(
          onTap: () {
            onTap();
          },
          key: const ValueKey("games"),
          leading: Icon(icon, color: Color(0xFF2a9d8f)),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2a9d8f),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
