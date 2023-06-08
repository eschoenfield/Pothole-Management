import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pothole_management/first.dart';
import 'package:pothole_management/googlePhoneMap.dart';
import 'package:pothole_management/second.dart';
import 'components/drawer.dart';

class AboutRoute extends StatelessWidget {
  const AboutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pothole Tracking System'),
        ),
        drawer: getDrawer(context),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(''),
                  const Text('Welcome to the pothole tracking system!'),
                  const Text(''),
                  ElevatedButton(
                    child: const Text("Browse Photos"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondRoute()));
                      // Navigator.pushNamed(context, '/second');
                    },
                  ),
                  const Text(''),
                  // ElevatedButton(
                  //   child: const Text("Show Map"),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/fourth');
                  //   },
                  // ),
                  const Text(''),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/first');
                  //   },
                  //   child: const Text('Submit a Photo'),
                  // ),
                ],
              ),
            )),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pothole Tracking System'),
        ),
        drawer: getDrawer(context),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(''),
                  const Text('Welcome to the pothole tracking system!'),
                  const Text(''),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FirstRoute()));
                      // Navigator.pushNamed(context, '/first');
                    },
                    child: const Text('Submit a Photo'),
                  ),
                  const Text(''),
                  ElevatedButton(
                    child: const Text("Browse Photos"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondRoute()));
                      // Navigator.pushNamed(context, '/second');
                    },
                  ),
                  const Text(''),
                  ElevatedButton(
                    child: const Text("Show in Map"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdRoute()));
                      // Navigator.pushNamed(context, '/third');
                    },
                  ),
                ],
              ),
            )),
      );
    };

  }
}
