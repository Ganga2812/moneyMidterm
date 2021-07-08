import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messageboard_app/screens/pages/gamechat.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String fname, String lname, String date) async {
    return await userCollection.doc(uid).set({
      'Full Name': fname + ' ' + lname,
      'First Name': fname,
      'Last Name': lname,
      'Register Date': date,
      'User Admin Role': false,
    });
  }
}

class DataPost {
  DataPost({dynamic});

  final CollectionReference gamesCollection =
      FirebaseFirestore.instance.collection('games');

  Future uploadDataGames(String username, String input, String dateTime) async {
    return await gamesCollection.doc().set({
      'Username': username,
      'Input': input,
      'Date': dateTime,
    });
  }

  final CollectionReference businessCollection =
      FirebaseFirestore.instance.collection('business');

  Future uploadDataBusiness(
      String username, String input, String dateTime) async {
    return await businessCollection.doc().set({
      'Username': username,
      'Input': input,
      'Date': dateTime,
    });
  }

  final CollectionReference healthCollection =
      FirebaseFirestore.instance.collection('health');

  Future uploadDataHealth(
      String username, String input, String dateTime) async {
    return await healthCollection.doc().set({
      'Username': username,
      'Input': input,
      'Date': dateTime,
    });
  }

  final CollectionReference studyCollection =
      FirebaseFirestore.instance.collection('study');

  Future uploadDataStudy(String username, String input, String dateTime) async {
    return await studyCollection.doc().set({
      'Username': username,
      'Input': input,
      'Date': dateTime,
    });
  }
}
