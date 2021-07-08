import 'package:flutter/material.dart';
import 'package:messageboard_app/screens/pages/businesschat.dart';
import 'package:messageboard_app/screens/pages/gamechat.dart';
import 'package:messageboard_app/screens/pages/health.dart';
import 'package:messageboard_app/screens/pages/study.dart';

class GroupList extends StatelessWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      children: <Widget>[
        SizedBox(
          height: 110,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Color(0xFF2a9d8f),
              )),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
              dense: true,
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => GameChatPage()));
              },
              leading: Image.asset(
                'assets/groupicons/games.jpg',
              ),
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Games',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2a9d8f),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Color(0xFF2a9d8f),
              )),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
              dense: true,
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BusinessChatPage()));
              },
              leading: Image.asset(
                'assets/groupicons/business.jpg',
              ),
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Business',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2a9d8f),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Color(0xFF2a9d8f),
              )),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
              dense: true,
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HealthChatPage()));
              },
              leading: Image.asset(
                'assets/groupicons/healthcare.jpg',
              ),
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Public Health',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2a9d8f),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Color(0xFF2a9d8f),
              )),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
              dense: true,
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => StudyChatPage()));
              },
              leading: Image.asset(
                'assets/groupicons/study.jpg',
              ),
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Study',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2a9d8f),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
