import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_to_nahin/models/PostModel.dart';
import 'package:fake_to_nahin/screens/PostScreen.dart';
import 'package:fake_to_nahin/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: DrawerButton(),
        ),
        appBar: AppBar(
          title: Text(
            'Fake To Nahin',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            // New Post Button
            RaisedButton(
              splashColor: Colors.white54,
              color: Colors.lightBlue[800],
              onPressed: () {
                Navigator.pushNamed(context, "CreatePost");
              },
              child: Row(children: [
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                Text(
                  'New Post',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ]),
            )
          ],
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(5),
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('posts')
                    .orderBy("dateCreated", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: Text(
                      'You haven\'t posted anything yet...',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ));
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => _buildPostCard(
                          context, snapshot.data.documents[index]));
                })));
  }

  Widget _buildPostCard(BuildContext context, DocumentSnapshot document) {
    var post = PostModel.toObject(document);
    post.id = document.documentID;

    return Card(
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostScreen(
                        post)), // the builder of MaterialPageRoute will call the TodoDetail class passing the todo that was passed.
              );
            },
            child: DecoratedBox(
                position: DecorationPosition.background,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                        color: Colors.grey,
                        width: 2,
                        style: BorderStyle.values[1])),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                text: post.title,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.lightBlue[800],
                                    fontWeight: FontWeight.bold))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('@' + post.username,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(post.dateCreated,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey))
                          ],
                        ),
                        Center(
                            child: (post.mediaPath != null)
                                ? Image.network(
                                    post.mediaPath,
                                    fit: BoxFit.contain,
                                    height: 250,
                                  )
                                : Text('')),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                            text: TextSpan(
                                text: post.description,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black))),
                        Center(
                            child: Text('Read More and View Resources',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline)))
                      ],
                      // crossAxisAlignment: CrossAxisAlignment.start,
                    )))));
  }
}
