import 'package:flutter/material.dart';
import 'package:ufp_library_mobile/screens/home.dart';
import 'package:ufp_library_mobile/services/api.dart';
import 'package:ufp_library_mobile/services/jwt.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('UFP Library')),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'User number'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your user number';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _user.number = val),
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password.';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _user.password = val)),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  onPressed: () async {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      _showDialog(context, 'Logging in...');
                                      User userToLogin = new User(number: _user.number, password: _user.password);
                                      try {
                                        User loggedInUser = await loginUser(body: userToLogin.toMap());
                                        User authenticatedUser = new User.authenticatedUser(id: parseJwt(loggedInUser.token).values.toList()[1], number: _user.number, 
                                          token: loggedInUser.token);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(authenticatedUser: authenticatedUser),
                                          ),
                                        );
                                      } on Exception catch(e) {
                                        _hideDialog(context);
                                        _showDialog(context, 'Error! Check your credentials...');
                                      }
                                    }
                                  },
                                  child: Text('Login'))),
                        ])))));
  }

  _showDialog(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  _hideDialog(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }
}