import 'package:fake_to_nahin/globals.dart' as globals;
import 'package:flutter/material.dart';

class DrawerButton extends StatefulWidget {
  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          addRepaintBoundaries: true,
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Hello ${globals.currentUser.firstName}!\n${'@' + globals.currentUser.username}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(globals.currentUser.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: globals.currentUser.imagePath == null
                    ? Text(
                        globals.currentUser.firstName[0] +
                            globals.currentUser.lastName[0],
                        style: TextStyle(fontSize: 40.0),
                      )
                    : CircleAvatar(
                        radius: double.infinity,
                        backgroundImage:
                            NetworkImage(globals.currentUser.imagePath)),

                // backgroundImage: NetworkImage(globals.currentUser.imagePath),
              ),
            ),
            // DrawerHeader(
            //   child: Column(
            //     children: <Widget>[
            //       // CircleAvatar(backgroundImage: ,),

            //       Text('Fake To Nahin',
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 24,
            //               color: Colors.white)),
            //     ],
            //   ),
            //   decoration: BoxDecoration(color: Colors.lightBlue[800]),
            // ),
            ListTile(
              title: Text('Home',
                  style: TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'Home', ModalRoute.withName('/'));
              },
            ),
            ListTile(
              title: Text('Profile',
                  style: TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
              onTap: () {
                Navigator.pushNamed(context, 'Profile');
              },
            ),
            ListTile(
              title: Text('My Posts',
                  style: TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
              onTap: () {
                Navigator.pushNamed(context, 'MyPosts');
              },
            ),
            // ListTile(title: Text('Saved Posts',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap: (){Navigator.pushNamed(context,'SavedPosts');},),
            ListTile(
              title: Text('Logout',
                  style: TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
              onTap: () {
                globals.currentUser = null;
                Navigator.pushNamedAndRemoveUntil(
                    context, 'SignIn', ModalRoute.withName('/'));
              },
            )
          ]),
    );
  }
}

// ListTile(
//     title: Text('Exit',
//         style:
//             TextStyle(color: Colors.lightBlue[800], fontSize: 20)),
//     onTap: () => exit(0)),
