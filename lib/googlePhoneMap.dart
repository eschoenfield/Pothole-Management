import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'firebase_options.dart';

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Display',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const ThirdScreen(title: 'Pothole Tracking System'),
    );
  }
}
class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final Map<String, Marker> _markers = {};

  //Geolocation of Chico, California;
  final LatLng _center = const LatLng(39.72726195560832, -121.84724266255505);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    //want to create a stream of "photos" collection data

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    var photo_collection = FirebaseFirestore.instance.collection("photos");
    var querySnapshot = await photo_collection.get();

    setState(() {
      _markers.clear();
      for (var queryDocumentSnapshot in querySnapshot.docs){
        Map<String,dynamic> data = queryDocumentSnapshot.data();
        final double latitu=data['geopoint'].latitude;
        final double longtitu=data['geopoint'].longitude;
        var marker = Marker(
          markerId: MarkerId(data['timestamp'].toString()),
          position: LatLng (latitu, longtitu),
          infoWindow: InfoWindow(
            title: LatLng (latitu, longtitu).toString(),
            snippet: data["downloadURL"],
          ),
        );
        _markers[data['title']]= marker;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pothole Tracking Map'),
          backgroundColor: Colors.green,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center, //Chico State Engineering,
            zoom: 12.0,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}