import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pothole_management/components/view_image_full.dart';
import 'components/drawer.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Browse Photos',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const SecondScreen(title: 'Pothole Tracking System'),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // bool initialized = false;
  // FirebaseApp? app;

  // Future<void> initializeDefault() async {
  //   app = await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  //   initialized = true;
  //   if (kDebugMode) {
  //     print('Initialized default app $app');
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initializeDefault();
  }

  void _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }



  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return FutureBuilder(
          future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error);
              }
              return Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                appBar: AppBar(
                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text(widget.title),
                ),
                drawer: getDrawer(context),
                body: Column(
                  children: [getBodyWeb()],
                ),
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     Navigator.defaultRouteName;
                //   },
                //   tooltip: 'To Homepage',
                //   child: const Icon(Icons.add),
                // ), // This trailing comma makes auto-formatting nicer for build methods.
              );
            }
            return CircularProgressIndicator();
          }));
    }else {
      return FutureBuilder(
          future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.error);
              }
              return Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                appBar: AppBar(
                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text(widget.title),
                ),
                drawer: getDrawer(context),
                body: Column(
                  children: [getBodyPhone()],
                ),
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     Navigator.defaultRouteName;
                //   },
                //   tooltip: 'To Homepage',
                //   child: const Icon(Icons.add),
                // ), // This trailing comma makes auto-formatting nicer for build methods.
              );
            }
            return CircularProgressIndicator();
          }));
    }

  }

  // Display the photo based on downloadURL
  // Widget photoWidget(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
  //   try {
  //     return Column(children: [
  //       ListTile(title: Text(snapshot.data!.docs[index]['title'])),
  //       Image.network(
  //         snapshot.data!.docs[index]['downloadURL'],
  //         height: 150,
  //       )
  //     ]);
  //   } catch (e) {
  //     return ListTile(title: Text("Error: $e"));
  //   }
  // }
  Widget getBodyWeb() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("photos").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) return const Text("Loading Photos");
          return Expanded(
              child: Scrollbar(
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              _launchUrl(
                                  Uri.parse(snapshot.data!.docs[index]['downloadURL']));
                            },
                            child: Card(
                              child: Column(children: [
                                ListTile(
                                  title: Text(snapshot.data!.docs[index]['title']),
                                ),
                                Image.network(
                                  snapshot.data!.docs[index]['downloadURL'],
                                  height: 150,)
                              ]),
                            ));
                        // return photoWidget(snapshot, index);
                      })));
        });
  }
  Widget getBodyPhone() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("photos").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) return const Text("Loading Photos");
          return Expanded(
              child: Scrollbar(
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ViewImageFull(
                                  urlString: snapshot.data!.docs[index]['downloadURL'],
                                )),
                              );
                              //launchUrl in a new page on web app
                              // _launchUrl(Uri.parse(snapshot.data!.docs[index]['downloadURL']));
                            },
                            child: Card(
                              child: Column(children: [
                                ListTile(
                                  title: Text(snapshot.data!.docs[index]['title']),
                                ),
                                Image.network(
                                  snapshot.data!.docs[index]['downloadURL'],
                                    height: 150,)
                              ]),
                            ));
                        // return photoWidget(snapshot, index);
                      })));
        });
  }
}
