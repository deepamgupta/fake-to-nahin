import 'dart:ui';

import 'package:fake_to_nahin/models/PostModel.dart';
import 'package:fake_to_nahin/models/ResourceModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class PostScreen extends StatefulWidget {
  final PostModel post;
  PostScreen(this.post);

  @override
  _PostScreenState createState() => _PostScreenState(post);
}

class _PostScreenState extends State<PostScreen> {
  PostModel post;
  _PostScreenState(this.post);
  TextEditingController resourceController = TextEditingController();
  String summary = "real";
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fake To Nahin',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            post.email == globals.currentUser.email
                ? RaisedButton(
                    textTheme: ButtonTextTheme.primary,
                    color: Theme.of(context).primaryColor,
                    splashColor: Colors.white54,
                    onPressed: () =>
                        deletePost().then((value) => {Navigator.pop(context)}),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.delete),
                        Text("Delete Post", style: TextStyle(fontSize: 17))
                      ],
                    ),
                  )
                : Text("")
          ],
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: ListView(
              primary: true,
              children: [
                Column(children: [
                  RichText(
                      text: TextSpan(
                          text: post.title,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.lightBlue[800],
                              fontWeight: FontWeight.bold))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('@' + post.username,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(post.dateCreated,
                          style: TextStyle(fontSize: 18, color: Colors.grey))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                    child: InkWell(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 400.0),
                          child: Image.network(
                            post.mediaPath,
                            fit: BoxFit.contain,
                          )),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 100.0),
                                child: PhotoView(
                                    enableRotation: true,
                                    imageProvider: NetworkImage(
                                      post.mediaPath,
                                    )));
                          },
                        );
                      },
                    ),
                  ),
                  Text("Description",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold)),
                  RichText(
                      text: TextSpan(
                          text: post.description,
                          style: TextStyle(fontSize: 19, color: Colors.black))),
                  Container(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Text(
                                'Links to Resources',
                                style: TextStyle(
                                    color: Colors.lightBlue[800],
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: RaisedButton(
                                  onPressed: () {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Enter a link',
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          content: SizedBox(
                                            height: 220.0,
                                            child: Column(children: [
                                              TextField(
                                                controller: resourceController,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter link here'),
                                              ),
                                              StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Column(
                                                  children: <Widget>[
                                                    RadioListTile<String>(
                                                      title: const Text('Real'),
                                                      value: "real",
                                                      groupValue: summary,
                                                      onChanged:
                                                          (String value) {
                                                        setState(() {
                                                          summary = value;
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile<String>(
                                                      title: const Text('Fake'),
                                                      value: "fake",
                                                      groupValue: summary,
                                                      onChanged:
                                                          (String value) {
                                                        setState(() {
                                                          summary = value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }),
                                              RaisedButton(
                                                  onPressed: () {
                                                    addResourceToPost().then(
                                                        (value) => {
                                                              resourceController
                                                                  .clear(),
                                                              Navigator.of(
                                                                      context)
                                                                  .pop()
                                                            });
                                                  },
                                                  child: Text('Post'))
                                            ]),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Post a Link',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  color: Colors.lightBlue[800],
                                ))
                          ],
                        ),
                        Column(children: <Widget>[
                          StreamBuilder(
                              stream: Firestore.instance
                                  .collection('posts')
                                  .document(post.id)
                                  .collection('resources')
                                  .orderBy("dateCreated", descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Text('No comments yet!!');
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (context, index) =>
                                        _buildResourceCards(context,
                                            snapshot.data.documents[index]));
                              })
                        ])
                      ]))
                ])
              ],
            )));
  }

  Future addResourceToPost() async {
    ResourceModel newResource = ResourceModel(
        globals.currentUser.username,
        globals.currentUser.email,
        DateFormat("d MMM yyyy, h:mm a").format(DateTime.now()),
        resourceController.text,
        summary);

    await Firestore.instance
        .collection('posts')
        .document(post.id)
        .collection('resources')
        .add(newResource.toMap());
  }

  Widget _buildResourceCards(BuildContext context, DocumentSnapshot document) {
    var resource = ResourceModel.toObject(document);
    resource.id = document.documentID;

    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '@' + resource.username,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                resource.dateCreated,
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Article Here',
                      style: TextStyle(fontSize: 16),
                    ),
                    InkWell(
                      onTap: () => launchURL(resource.link),
                      child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: resource.link,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline))),
                    ),
                  ],
                ),
                flex: 11,
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('In-Short'),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: resource.summary == "real"
                                    ? AssetImage('assets/img/genuine-stamp.png')
                                    : AssetImage('assets/img/fake-stamp.png'))

                            //     color: resource.summary == "real"
                            //         ? Colors.green
                            //         : Colors.red),
                            // child: Center(
                            //   child: Padding(
                            //     padding: EdgeInsets.all(3.0),
                            //     child: Text(
                            //       resource.summary == "real" ? "REAL" : "FAKE",
                            //       style: TextStyle(
                            //           fontSize: 16,
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.bold,
                            //           backgroundColor: resource.summary == "real"
                            //               ? Colors.green
                            //               : Colors.red),
                            //     ),
                            //   ),
                            ),
                        child: Text('                   \n\n'),
                      )
                    ],
                  ))
            ],
          ),

          // DecoratedBox(
          //     decoration: BoxDecoration(
          //         color: resource.summary == "real" ? Colors.green : Colors.red,
          // ))
        ],
      ),
    );
  }

  launchURL(link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  Future deletePost() async {
    RegExp regExp = new RegExp(
      r"com\/o(.*?)\?alt",
      caseSensitive: false,
      multiLine: false,
    );

    var mediaPath =
        regExp.firstMatch(post.mediaPath).group(1).replaceAll('%2F', '/');
    // delete all links to the post
    await Firestore.instance
        .collection("posts")
        .document(post.id)
        .collection('resources')
        .getDocuments()
        .then((snapshot) => {
              for (DocumentSnapshot ds in snapshot.documents)
                {ds.reference.delete()}
            });

    // delete image from firestorage
    await FirebaseStorage.instance.ref().child(mediaPath).delete();

    // delete post
    await Firestore.instance.collection("posts").document(post.id).delete();
  }
}
