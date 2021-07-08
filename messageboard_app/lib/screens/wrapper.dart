import 'package:messageboard_app/models/user.dart';
import 'package:messageboard_app/screens/authenticate/authentication.dart';
import 'package:messageboard_app/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ObjectUser?>(context);

    //return either Home or authentication
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
