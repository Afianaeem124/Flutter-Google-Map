import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;

  List<String> images = [
    'assets/car.png',
    'assets/car2.png',
    'assets/home.png',
    'assets/location.png',
    'assets/motorcycle.png',
    'assets/scooter.png',
  ];

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latlng = <LatLng>[
    LatLng(24.9380, 67.0479),
    LatLng(24.8825, 67.0694),
    LatLng(24.9389, 67.1237),
    LatLng(24.9729, 67.0643),
    LatLng(25.0351, 67.1406),
    LatLng(24.7906, 67.0404)
  ];
  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(24.9380, 67.0479), zoom: 14);

  Future<Uint8List> getBytesFromImage(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromImage(images[i].toString(), 100);
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latlng[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
                title: 'This is Title Marker:' + (i + 1).toString())),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
