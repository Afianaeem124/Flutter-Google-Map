import 'package:flutter/material.dart';
import 'package:google_maps/Convert_latlng_to_address.dart';
import 'package:google_maps/Custom_Marker_Info_Window.dart';
import 'package:google_maps/Custom_Style-GoogleMap.dart';
import 'package:google_maps/Network.dart';
import 'package:google_maps/PolyLineScreen.dart';
import 'package:google_maps/PolygoneScreen.dart';
import 'package:google_maps/current_locator.dart';
import 'package:google_maps/custom_marker_screen.dart';
import 'package:google_maps/google_placesAPI.dart';
import 'package:google_maps/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: CustomStyleGoogleMap(),
    );
  }
}
