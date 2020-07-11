import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_to_nahin/globals.dart' as globals;
import 'package:fake_to_nahin/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';

import '../models/UserModel.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  Directory dir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/img/logo_title.png'))),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.person), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailLoginController,
                          decoration: InputDecoration(hintText: 'Email'),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: passwordLoginController,
                          decoration: InputDecoration(hintText: 'Password'),
                          obscureText: true,
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: () {
                    getData(emailLoginController.text.trim())
                        .then((userDoc) => {
                              loginUser()

                              //   if (userDoc.data["password"] ==
                              //       passwordLoginController.text)
                              //     {onSuccess(userDoc.data)}
                              //   else
                              //     {
                              //       showDialog(
                              //         context: context,
                              //         builder: (context) {
                              //           return AlertDialog(
                              //             content: Text("Password Incorrect"),
                              //           );
                              //         },
                              //       )
                              //     }
                            });
                  },
                  color: Colors.lightBlue[800],
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'SignUp');
            },
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: 'Don\'t have an account?  ',
                    style: TextStyle(color: Colors.black, fontSize: 17.0),
                    children: [
                      TextSpan(
                        text: 'SIGN UP',
                        style: TextStyle(
                            color: Colors.lightBlue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Made with ❤️ in 🇮🇳',
                style: TextStyle(color: Colors.black, fontSize: 19.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getData(String uid) async {
    final usersCollectionRef = Firestore.instance.collection("users");
    return usersCollectionRef.document(uid).get();
  }

  onSuccess(userDataMap) async {
    // Directory dir = await getApplicationDocumentsDirectory();
    // String path = dir.path + "current_user.json";

    // File loggedInUserFile = new File(path);
    // // print(userDataObj);
    // loggedInUserFile.writeAsStringSync(jsonEncode(userDataMap));
    globals.currentUser = UserModel.toObject(userDataMap);
    Navigator.pushReplacementNamed(context, 'Home');
  }

  loginUser() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: emailLoginController.text.trim(),
              password:
                  Password.hash(passwordLoginController.text, new PBKDF2())
                      .toString()))
          .user;
      if (user.isEmailVerified) {
        Firestore db = Firestore.instance;
        DocumentSnapshot userSnapshot =
            await db.collection("users").document(user.email).get();
        // UserModel loggedInUser = UserModel.toObject(userSnapshot);
        // globals.currentUser = loggedInUser;
        onSuccess(userSnapshot);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password Incorrect or User Not Verified"),
            );
          },
        );
      }
    } catch (err) {
      print(err);
    }
  }
}

// return showDialog(
//   context: context,
//   builder: (context) {
//     return AlertDialog(
//       content: Text(currentUser.firstName),
//     );
//   },
// );
