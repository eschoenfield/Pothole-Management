import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pothole_management/googlePhoneMap.dart';
import 'googleWebMap.dart';
import 'second.dart';
import 'first.dart';
import 'about.dart';

void main() {

  if (kIsWeb) {
    runApp(MaterialApp(
      title: 'Named Routes Demo Web',
      // Start the app with the "/about" named route. In this case, the app starts
      // on the About widget.
      initialRoute: '/',

      routes: {

        // When navigating to the "/about" route, build the AboutScreen widget.
        '/': (context) => const AboutRoute(),
        // When navigating to the "/first" route, build Take a photo widget.
        // '/first': (context) => const FirstRoute(),
        // When navigating to the "/second" route, build browse photo widget.
        '/second': (context) => const SecondRoute(),
        // when navigating to the "/fourth" route, build google map web
        // '/fourth': (context) => const FourthRoute(),
      },
    ));
  } else {
    runApp(MaterialApp(
      title: 'Named Routes Demo Mobile',
      // Start the app with the "/about " named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/about" route, build the AboutScreen widget.
        '/': (context) => const AboutRoute(),
        // When navigating to the "/first" route, build the Take a photo widget.
        '/first': (context) => const FirstRoute(),
        // When navigating to the "/second" route, build the browse photo widget.
        '/second': (context) => const SecondRoute(),
        // When navigating to the "/third" route, build the Google map widget.
        '/third': (context) => const ThirdRoute(),
      },
    ));
  }
}
