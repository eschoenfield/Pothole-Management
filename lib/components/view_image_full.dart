import 'package:flutter/material.dart';


class ViewImageFull extends StatelessWidget {
  final String? urlString;
  const ViewImageFull({required this.urlString});



  @override
  Widget build(BuildContext context) {

      return new Scaffold(
        body: new Image.network(
          urlString!,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      );
  }
}