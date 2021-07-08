import 'package:messageboard_app/screens/home.dart';
import 'package:messageboard_app/services/auth.dart';
import 'package:messageboard_app/shared/constants.dart';
import 'package:messageboard_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  // const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Create instant object _auth
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // White Color
            backgroundColor: Color(0xFFFFFFFF),
            appBar: AppBar(
              backgroundColor: Color(0xFF2a9d8f),
              elevation: 0.0,
              title: Text('Sign In to Group Chat'),
              actions: <Widget>[
                FlatButton.icon(
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () async {
                    widget.toggleView();
                  },
                  label: Text("Register"),
                  icon: Icon(Icons.person_outlined),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter a valid Email' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Enter Email'),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (value) => value!.length < 6
                          ? 'Enter an 6+ chars long password'
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Enter Password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signinWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Could not sign in with those cedentials';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text('Sign In',
                          style: TextStyle(color: Color(0xFFFFFFFF))),
                      color: Color(0xFF2a9d8f),
                    ),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                    Text('Or'),
                    SignInButton(
                      Buttons.Google,
                      text: "Sign in with Google",
                      onPressed: () async {
                        _auth.signInWithGoogle();
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
