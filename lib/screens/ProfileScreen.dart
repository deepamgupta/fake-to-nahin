import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_to_nahin/widgets/drawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:fake_to_nahin/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerButton(),
      appBar: AppBar(
        title: Text('Your Profile',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'ProfileEdit');
            },
            child: Row(children: [
              Icon(Icons.edit),
              Text('Edit Profile', style: TextStyle(fontSize: 20))
            ]),
            color: Colors.lightBlue[800],
            textColor: Colors.white,
          )
        ],
      ),
      body: ListView(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              width: 200,
              height: 250,
              child: Stack(alignment: Alignment.center, children: [
                Positioned(
                    top: 220,
                    child: Text(globals.currentUser.username,
                        style: TextStyle(
                            color: Colors.lightBlue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        textAlign: TextAlign.center)),
                Positioned(
                  top: 7,
                  width: 200,
                  height: 200,
                  child: CircleAvatar(
                      backgroundImage: (globals.currentUser.imagePath != null)
                          ? NetworkImage(globals.currentUser.imagePath)
                          : AssetImage('assets/img/logo.png')),
                ),
                Positioned(
                    top: 180,
                    child: CircleAvatar(
                      child: IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          getImage().then((value) async => {
                                deleteImage(),
                                uploadFile().then((value) async => {
                                      globals.currentUser.imagePath = value,
                                      await Firestore.instance
                                          .collection('users')
                                          .document(globals.currentUser.email)
                                          .setData({
                                        'imagePath':
                                            globals.currentUser.imagePath
                                      }, merge: true),
                                      await Navigator.pushReplacementNamed(
                                          context, 'Profile')
                                    })
                              });
                        },
                      ),
                      backgroundColor: Colors.lightBlue[800],
                    ))
              ]),
            ),
            Card(
                margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                child: Row(
                  children: [
                    Text('Name:', style: TextStyle(fontSize: 20)),
                    Text(
                        capitalize(globals.currentUser.firstName) +
                            ' ' +
                            capitalize(globals.currentUser.lastName),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('City:', style: TextStyle(fontSize: 20)),
                    Text(capitalize(globals.currentUser.city),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('State:', style: TextStyle(fontSize: 20)),
                    Text(capitalize(globals.currentUser.state),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Country:', style: TextStyle(fontSize: 20)),
                    Text(capitalize(globals.currentUser.country),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Mobile:', style: TextStyle(fontSize: 20)),
                    Text(capitalize(globals.currentUser.mobile),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('E-mail ID:', style: TextStyle(fontSize: 20)),
                    Expanded(
                      child: Text(globals.currentUser.email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            // Card(
            //     margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            //     child: Row(
            //       children: [
            //         Text('Password:', style: TextStyle(fontSize: 20)),
            //         RaisedButton(
            //           onPressed: () {
            //             Navigator.pushNamed(context, 'ChangePassword');
            //           },
            //           child: Text('Change Password',
            //               style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white)),
            //           color: Colors.lightBlue[800],
            //         ),
            //       ],
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //     )),
          ]),
    );
  }

  String capitalize(word) {
    return "${word[0].toUpperCase()}${word.substring(1)}";
  }

  Future<String> uploadFile() async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${Path.basename(_image.path)}');
    final StorageUploadTask uploadTask = storageReference.putFile(_image);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future deleteImage() async {
    RegExp regExp = new RegExp(
      r"com\/o(.*?)\?alt",
      caseSensitive: false,
      multiLine: false,
    );

    var mediaPath = regExp
        .firstMatch(globals.currentUser.imagePath)
        .group(1)
        .replaceAll('%2F', '/');
    // delete image from firestorage
    await FirebaseStorage.instance.ref().child(mediaPath).delete();
  }
}
