import 'dart:io';
import 'package:fake_to_nahin/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:fake_to_nahin/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

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
            child: Row(children: [Icon(Icons.edit), Text('Edit Profile')]),
            color: Colors.lightBlue[800],
            textColor: Colors.white,
          )
        ],
      ),
      body: ListView(
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
          children: [
            Container(
              child: CircleAvatar(backgroundColor: Colors.lightBlue[800],child:IconButton(icon:Icon(Icons.add_a_photo,size:26),onPressed:(){
                getImage();
              },),radius: 25,),
                height: 200,
                width: 200,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(fit: BoxFit.contain,alignment: Alignment.center,image: (_image==null)?AssetImage('assets/img/logo.png'):FileImage(_image)))),
            Text(globals.currentUser.username,
                style: TextStyle(
                    color: Colors.lightBlue[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textAlign: TextAlign.center),
            Card(
                margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                child: Row(
                  children: [
                    Text('Name:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.firstName)+' '+capitalize(globals.currentUser.lastName),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('City:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.city),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('State:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.state),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Country:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.country),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('Mobile:', style: TextStyle(fontSize: 22)),
                    Text(capitalize(globals.currentUser.mobile),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text('E-mail ID:', style: TextStyle(fontSize: 22)),
                    Text(globals.currentUser.email,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )),
            Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                // child: Row(
                //   children: [
                //     Text('Password:', style: TextStyle(fontSize: 22)),
                //     RaisedButton(
                //         onPressed: () {},
                //         child: Text('Change Password',
                //             style: TextStyle(
                //                 fontSize: 22, fontWeight: FontWeight.bold))),
                //   ],
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                // )
                ),
          ]),
    );
  }
  
  String capitalize(word) {
      return "${word[0].toUpperCase()}${word.substring(1)}";
    }

}
