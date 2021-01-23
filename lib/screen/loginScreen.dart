import 'package:flutter/material.dart';
import 'package:flutter_node/provider/auth.dart';
import 'package:flutter_node/screen/dashboardScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _submitting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flavor a Provider'),
      ),
      body: Center(
        child: _submitting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RaisedButton(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () async {
                  try {
                    setState(() => _submitting = true);
                    await Provider.of<AuthProvider>(context, listen: false)
                        .login();
                    setState(() => _submitting = false);
                    Navigator.of(context)
                        .pushReplacementNamed(DashBoardScreen.routeName);
                  } catch (e) {
                    print(e);
                    setState(() => _submitting = false);
                  }
                },
              ),
      ),
    );
  }
}
