import 'package:cloud_firestore/cloud_firestore.dart';

import '../globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          actions: [
            RaisedButton(
              onPressed: () {
                _formKey.currentState.save();
                createUser().then((value) => {
                      Navigator.pop(context),
                      Navigator.popAndPushNamed(context, 'Profile')
                    });
              },
              child: Row(children: [
                Icon(Icons.save),
                Text('Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 20))
              ]),
              color: Colors.lightBlue[800],
              textColor: Colors.white,
            )
          ],
        ),
        body: Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                scrollDirection: Axis.vertical,
                children: [
                  Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('First Name:',
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                              flex: 5,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  initialValue: globals.currentUser.firstName,
                                  cursorWidth: 2,
                                  onSaved: (value) {
                                    globals.currentUser.firstName =
                                        value.trim();
                                  })),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )),
                  Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('Last Name:',
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                              flex: 5,
                              child: TextFormField(
                                  initialValue: globals.currentUser.lastName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  cursorWidth: 2,
                                  onSaved: (value) {
                                    globals.currentUser.lastName = value.trim();
                                  })),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )),
                  Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('Username:',
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                              flex: 5,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  initialValue: globals.currentUser.username,
                                  cursorWidth: 2,
                                  onSaved: (value) {
                                    globals.currentUser.username = value.trim();
                                  })),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )),
                  Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('City:',
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                              flex: 5,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  initialValue: globals.currentUser.city,
                                  cursorWidth: 2,
                                  onSaved: (value) {
                                    globals.currentUser.city = value.trim();
                                  })),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )),
                  Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('State:',
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                              flex: 5,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  initialValue: globals.currentUser.state,
                                  cursorWidth: 2,
                                  onSaved: (value) {
                                    globals.currentUser.state = value.trim();
                                  })),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )),
                  Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('Country:',
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                              flex: 5,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.text,
                                  initialValue: globals.currentUser.country,
                                  cursorWidth: 2,
                                  onSaved: (value) {
                                    globals.currentUser.country = value.trim();
                                  })),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )),
                  Card(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('Mobile No.:',
                                  style: TextStyle(fontSize: 20))),
                          Expanded(
                              flex: 5,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.phone,
                                  initialValue: globals.currentUser.mobile,
                                  cursorWidth: 2,
                                  onSaved: (value) {
                                    globals.currentUser.mobile = value.trim();
                                  })),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )),
                ])));
  }

  String capitalize(word) {
    return "${word[0].toUpperCase()}${word.substring(1)}";
  }

  Future createUser() async {
    var userMap = globals.currentUser.toMap();
    final db = Firestore.instance;
    await db
        .collection("users")
        .document(globals.currentUser.email)
        .setData(userMap);
  }
}
