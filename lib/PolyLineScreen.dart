import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition GooglePlex =
      CameraPosition(target: LatLng(24.9380, 67.0479), zoom: 14);

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};

  final List<LatLng> _latlng = <LatLng>[
    LatLng(24.9380, 67.0479),
    LatLng(24.8825, 67.0694),
    LatLng(24.9389, 67.1237),
    LatLng(24.9729, 67.0643),
    LatLng(25.0351, 67.1406),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < _latlng.length; i++) {
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          infoWindow:
              InfoWindow(title: 'Really good Place', snippet: 'five star')));
      setState(() {});

      _polyline.add(Polyline(
          polylineId: PolylineId('1'),
          points: _latlng,
          width: 5,
          color: Colors.deepOrange,
          jointType: JointType.mitered));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: GooglePlex,
            markers: Set<Marker>.of(_marker),
            mapType: MapType.normal,
            polylines: _polyline,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
      ),
    );
  }
}
