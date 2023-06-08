import 'package:flutter/material.dart';
import 'package:pothole_management/about.dart';
import 'package:pothole_management/first.dart';
import 'package:pothole_management/second.dart';

Widget getDrawer(context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    //   child: ListView(
    //     // Important: Remove any padding from the ListView.
    //     padding: EdgeInsets.zero,
    //     children: [
    //       const DrawerHeader(
    //         decoration: BoxDecoration(
    //           color: Colors.blue,
    //         ),
    //         child: Text('Pages'),
    //       ),
    //       ListTile(
    //         title: const Text('Home'),
    //         onTap: () {
    //           Navigator.popUntil(context, ModalRoute.withName('/'));
    //         },
    //       ),
    //       ListTile(
    //           title: const Text('Take Photos'),
    //           onTap: () {
    //             // Navigator.pushNamed(context, '/second');
    //             Navigator.pushNamed(context, '/first');
    //           }),
    //       ListTile(
    //         title: const Text('Browse Photos'),
    //         onTap: () {
    //           // Navigator.pushNamed(context, '/second');
    //           Navigator.pushNamed(context, '/second');
    //         },
    //       ),
    //     ],
    //   ),
    // );
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Options'),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
          ),
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutRoute()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.phone_android,
          ),
          title: const Text('Submit Photo'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FirstRoute()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.photo_album,
          ),
          title: const Text('Browse Photos'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondRoute()));
          },
        ),
      ],
    ),
  );
}