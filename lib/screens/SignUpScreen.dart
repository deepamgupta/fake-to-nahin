import 'package:fake_to_nahin/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password/password.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: MyCustomForm()),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  UserModel newUserModel = new UserModel();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            height: 150.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/img/logo.png'))),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.firstName = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.lastName = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.username = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email Id'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.email = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Mobile'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.mobile = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Country'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.country = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'State'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.state = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.city = value;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) {
              newUserModel.password = Password.hash(value, new PBKDF2());
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // _formKey.currentState.validate();
                // Store user in Database
                _formKey.currentState.save();
                createUser().then((value) => {Navigator.of(context).pop()});
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future createUser() async {
    try {
      var userMap = newUserModel.toMap();
      final db = Firestore.instance;
      await db
          .collection("users")
          .document(newUserModel.email)
          .setData(userMap);

      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: newUserModel.email,
        password: newUserModel.password,
      ))
          .user;
      user.sendEmailVerification().then((value) => print("EMail Sent"));
      print(user.toString());
    } catch (err) {
      print(err.toString());
    }
  }
}
