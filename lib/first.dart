import 'package:cloud_firestore/cloud_firestore.dart';
import 'components/drawer.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'second.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CINS467 Project',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Pothole Tracking System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Position> _position;
  final myController = TextEditingController();
  String size = "";
  File? _image;
  String? _filename;
  bool _initialized = false;
  FirebaseApp? app;

  Future<void> initializeDefault() async {
    app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _initialized = true;
    if (kDebugMode) {
      print('Initialized default app $app');
    }
  }

  @override
  void dispose() {
    // Clear text editing controller
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeDefault();
    _position = _determinePosition();
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      _position = returnPosition(position);
      if (kDebugMode) {
        print(position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, '
                '${position.longitude.toString()}');
      }
    });
  }

  void _getImage() async {
    // Initialize a new Firebase App instance
    //await Firebase.initializeApp();
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _filename = path.basename(pickedImage.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future<String> _uploadFile(filename) async {
    if (!_initialized) {
      await initializeDefault();
    }
    final Reference ref = FirebaseStorage.instance.ref().child('$filename.jpg');
    final SettableMetadata metadata =
        SettableMetadata(contentType: 'image/jpeg', contentLanguage: 'en');
    final UploadTask uploadTask = ref.putFile(_image!, metadata);
    final downloadURL = await (await uploadTask).ref.getDownloadURL();
    if (kDebugMode) {
      print(downloadURL.toString());
    }
    return downloadURL.toString();
  }

  Future<void> _upload() async {
    if (_image != null) {
      var uuid = Uuid();
      final String uid = uuid.v4();
      if (kDebugMode) {
        print(uid);
      }
      size = myController.text;
      final String downloadURL = await _uploadFile(uid);
      await _addItem(downloadURL, uid, size);
      await alertDialog(context);
      // Refresh the UI
      setState(() {});
    }
  }

  Future<void> _addItem(
      String downloadURL, String title, String dimensions) async {
    if (!_initialized) {
      await initializeDefault();
    }
    if (_position != null) {
      Position pposition =
          await _position; //Assign Future Position to current Position using await.
      await FirebaseFirestore.instance
          .collection('photos')
          .add(<String, dynamic>{
        'downloadURL': downloadURL,
        'title': title,
        'geopoint': GeoPoint(pposition.latitude, pposition.longitude),
        'timestamp': DateTime.now(),
        'dimensions': dimensions
      });
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> returnPosition(position) {
    return position;
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = kIsWeb;
    if (isWeb) {
      // running on the web - simple UI
      return FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
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
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: ((context) =>
                //                 SecondScreen(title: "Get a photo"))));
                //   },
                //   tooltip: 'Add a photo',
                //   child: const Icon(Icons.add_a_photo),
                // ), // This trailing comma makes auto-formatting nicer for build methods.
              );
            }
            return CircularProgressIndicator();
          }));
    } else {
      // running on the phone
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        drawer: getDrawer(context),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getBodyPhone(),
          ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: _getImage,
          tooltip: 'Add a photo',
          child: const Icon(Icons.add_a_photo),
        ), // This trailing comma makes auto-formatting nicer for build methods./ This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

  List<Widget> getBodyPhone() {
    List<Widget> list = List.empty(growable: true);
    list.add(
      const Text('The time of the photo is:'),
    );
    _image == null
        ? list.add(const Text(''))
        : list.add(Text(DateTime.now().toIso8601String()));

    _image == null
        ? list.add(
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Placeholder(
                child: Image.network(
                    "https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),
              ),
              width: 250.0,
              height: 250.0,
            ),
          )
        : list.add(Container(
            margin: const EdgeInsets.all(10.0),
            child: Image.file(_image!),
            width: 250.0,
            height: 250.0,
          ));
    list.add(
      const Text('The location of the photo is:'),
    );
    _image == null
        ? list.add(const Text(''))
        : list.add(FutureBuilder<Position>(
            future: _position,
            builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                        '${snapshot.data!.latitude}, ${snapshot.data!.longitude}, '
                        '${snapshot.data!.accuracy}');
                  }
              }
            }));
    list.add(
      TextField(
        controller: myController,
        decoration: const InputDecoration(
          icon: Icon(Icons.telegram),
          hintText: 'Enter Width ft x Length ft x Depth ft',
          labelText: 'Input Size of Pothole',
        ),
      ),
    );

    _image == null
        ? list.add(const Text(''))
        : list.add(
            ElevatedButton(
              onPressed: () => _upload(), //() => print("nothing") , //submit,
              child: const Text('Submit'),
            ),
          );
    list.add(
      const Text(''),
    );
    // list.add(
    //   ElevatedButton(
    //     child: const Text("Browse Photos"),
    //     onPressed: () {
    //         Navigator.pushNamed(context, '/second');
    //     },
    //   ),
    // );
    list.add(
      const Text(''),
    );
    _image == null
        ? list.add(const Text(''))
        : list.add(
            ElevatedButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
                child: Text("close")),
          );
    return list;
  }

  Future alertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done'),
            content: Text('Add Success'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Success'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Widget photoWidget(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    try {
      return Column(children: [
        ListTile(title: Text(snapshot.data!.docs[index]['title'])),
        Image.network(
          snapshot.data!.docs[index]
              ['downloadURL'], //how to do this? This doesn't work for web.
          height: 150,
        )
      ]);
    } catch (e) {
      return ListTile(title: Text("Error: $e"));
    }
  }

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
                        return photoWidget(snapshot, index);
                      })));
        });
  }
}
