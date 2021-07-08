import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameList extends StatefulWidget {
  // const UserList({Key? key}) : super(key: key);

  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  // int count = 0;
  // String press = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .orderBy('Date')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // var arr = snapshot.data!.docs.map((document) => document['Input']);
          else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        // leading: Icon(Icons.podcasts_outlined),
                        isThreeLine: true,
                        tileColor: Color(0x55caf0f8),
                        title: Text(
                          '${doc['Input']}',
                        ),

                        subtitle: Text(
                          "${doc['Username']}\n${doc['Date'].toString().substring(0, 10)} at ${doc['Date'].toString().substring(11, 16)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF0096c7),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              // '${snapshot.data!.docs.map((document) => document['Input'])}'),
            );
          }
        },
      ),
    );
  }
}
