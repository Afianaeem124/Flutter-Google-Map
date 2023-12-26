import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonState();
}

class _PolygonState extends State<PolygonScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition GooglePlex =
      CameraPosition(target: LatLng(24.9380, 67.0479), zoom: 14);

  final Set<Marker> _marker = {};

  Set<Polygon> _polygon = HashSet<Polygon>();

  final List<LatLng> _latlng = <LatLng>[
    LatLng(24.9380, 67.0479),
    LatLng(24.8825, 67.0694),
    LatLng(24.8840, 66.9928),
    LatLng(24.9380, 67.0479),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(Polygon(
        polygonId: PolygonId('1'),
        points: _latlng,
        fillColor: Colors.red.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrangeAccent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: GooglePlex,
            markers: Set<Marker>.of(_marker),
            mapType: MapType.normal,
            polygons: _polygon,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
      ),
    );
  }
}
