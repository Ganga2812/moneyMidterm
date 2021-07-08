import 'package:messageboard_app/services/auth.dart';
import 'package:messageboard_app/shared/constants.dart';
import 'package:messageboard_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  // const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// Create instant object _auth
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state

  String fname = '';
  String lname = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // resizeToAvoidBottomInset: false,
            // White Color
            backgroundColor: Color(0xFFFFFFFF),
            appBar: AppBar(
              backgroundColor: Color(0xFF2a9d8f),
              elevation: 0.0,
              title: Text('Sign Up to Group Chat'),
              actions: <Widget>[
                FlatButton.icon(
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () async {
                    widget.toggleView();
                  },
                  label: Text("Sign In"),
                  icon: Icon(Icons.person_outlined),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter First Name' : null,
                      onChanged: (value) {
                        setState(() => fname = value);
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'First Name'),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter Last Name' : null,
                      onChanged: (value) {
                        setState(() => lname = value);
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Last Name'),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an Email' : null,
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
                      obscureText: true,
                      validator: (value) => value!.length < 6
                          ? 'Enter an 6+ chars long password'
                          : null,
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
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  fname, lname, email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                              setState(() => loading = false);
                            });
                          }
                        }
                      },
                      child: Text('Register',
                          style: TextStyle(color: Color(0xFFFFFFFF))),
                      color: Color(0xFF2a9d8f),
                    ),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14))
                  ],
                ),
              ),
            ),
          );
  }
}
