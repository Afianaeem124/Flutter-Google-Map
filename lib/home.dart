import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition GooglePlex =
      CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);

  List<Marker> _marker = <Marker>[];

  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(40.3399, 127.5101),
        infoWindow: InfoWindow(title: 'North Korea')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(33.5651, 73.0169),
        infoWindow: InfoWindow(title: ' Rawalpindi')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: 'Islamabad')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
    /*_marker.add(
      Marker(
          markerId: MarkerId('1'),
          position: LatLng(24.9380, 67.0479),
          infoWindow: InfoWindow(title: 'My Position')),
    );
   */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
              initialCameraPosition: GooglePlex,
              markers: Set<Marker>.of(_marker),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.location_disabled_outlined),
            onPressed: () async {
              GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(40.3399, 127.5101), zoom: 14),
              ));
              setState(
                () {},
              );
            }));
  }
}
