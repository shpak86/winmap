import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/AuthorizationProvider.dart';
import 'package:winmap/components/LeadingIconButton.dart';

class ConfigurationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConfigurationScreenState();
  }
}

class ConfigurationScreenState extends State<ConfigurationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loggedIn;
  bool _loginButtonDisabled = false;
  String _loggedInEmail = "";

  @override
  void initState() {
    super.initState();
    AuthorizationProvider.check().then((authorized) {
      setState(() {
        _loggedIn = authorized;
        _loggedInEmail = AuthorizationProvider.email;
      });
    });
  }

  _showLogin(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "E-mail"),
              controller: _emailController,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              controller: _passwordController,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                        child: Text("Login"),
                        onPressed: _loginButtonDisabled
                            ? null
                            : () {
                                setState(() {
                                  _loginButtonDisabled = true;
                                });
                                AuthorizationProvider.check(email: _emailController.text, password: _passwordController.text).then((authorized) {
                                  if (authorized) {
                                    setState(() {
                                      _loggedInEmail = AuthorizationProvider.email;
                                      _loggedIn = true;
                                      _loginButtonDisabled = false;
                                    });
                                    Navigator.popUntil(context, ModalRoute.withName("/"));
                                  } else {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.redAccent[100],
                                        content: const Text('Wrong email or password'),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: Scaffold.of(context).hideCurrentSnackBar,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      _loggedIn = false;
                                      _loginButtonDisabled = false;
                                    });
                                  }
                                });
                              }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showLogout(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            Text(_loggedInEmail),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                        color: Colors.red,
                        child: Text("Logout"),
                        onPressed: () {
                          AuthorizationProvider.exit();
                          setState(() {
                            _loggedIn = false;
                            _loggedInEmail = "";
                          });
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.settings,
          tag: "configuration",
        ),
        title: Text("Settings"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (_loggedIn == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _loggedIn ? _showLogout(context) : _showLogin(context);
          }
        },
      ),
    );
  }
}
