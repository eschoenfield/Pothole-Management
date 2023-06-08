// import 'dart:html';
// import 'package:flutter/material.dart';
// import 'package:google_maps/google_maps.dart';
// import 'dart:ui' as ui;
//
//
// class FourthRoute extends StatelessWidget {
//   const FourthRoute({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Map Display',
//       theme: ThemeData(
//         primarySwatch: Colors.lightGreen,
//       ),
//       home: const FourthScreen(title: 'Pothole Tracking System'),
//     );
//   }
// }
//
// class FourthScreen extends StatefulWidget {
//   const FourthScreen({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   State<FourthScreen> createState() => _FourthScreenState();
// }
//
// class _FourthScreenState extends State<FourthScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     getMap();
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('Pothole Tracking Map'),
//               backgroundColor: Colors.green,
//             ),
//             body:Column(
//               children: const <Widget>[
//                 Text('Try this new feature'),
//                 Text('Try this new UIs'),
//               ],
//             )
//         ),
//     );
//   }
// }
//
// Widget getMap() {
//   String htmlId = "7";
//
//   // ignore: undefined_prefixed_name
//   ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//     final myLatlng = LatLng(1.3521, 103.8198);
//
//     final mapOptions = MapOptions()
//       ..zoom = 10
//       ..center = LatLng(1.3521, 103.8198);
//
//     final elem = DivElement()
//       ..id = htmlId
//       ..style.width = "100%"
//       ..style.height = "100%"
//       ..style.border = 'none';
//
//     final map = GMap(elem, mapOptions);
//
//     Marker(MarkerOptions()
//       ..position = myLatlng
//       ..map = map
//       ..title = 'Hello World!'
//     );
//
//     return elem;
//   });
//
//   return HtmlElementView(viewType: htmlId);
// }