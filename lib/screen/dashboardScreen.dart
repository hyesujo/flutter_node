import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoardScreen'),
      ),
      body: Center(
        child: Text(
          'Dashboard',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
