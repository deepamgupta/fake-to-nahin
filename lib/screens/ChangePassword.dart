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
      appBar: AppBar(
        title: Text(
          'ChangePassword',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          SizedBox(height: 25),
          Row(children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(hintText: 'Current Password'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              cursorWidth: 2,
            ))
          ]),
          SizedBox(height: 25),
          Row(children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(hintText: 'Enter New Password'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              cursorWidth: 2,
            ))
          ]),
          SizedBox(height: 25),
          Row(children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(hintText: 'Confirm New Password'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              cursorWidth: 2,
            ))
          ]),
          SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            RaisedButton(
              onPressed: () {},
              child: Text('Change Password'),
            )
          ])
        ],
      ),
    );
  }
}
