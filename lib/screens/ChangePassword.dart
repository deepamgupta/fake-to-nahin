import 'package:fake_to_nahin/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerButton(),
      appBar:AppBar(
        title: Text('ChangePassword',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),

      ),
    );
  }
}