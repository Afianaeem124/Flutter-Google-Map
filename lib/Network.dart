import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';
import 'dart:ui' as ui;

class Network_Screen extends StatefulWidget {
  const Network_Screen({super.key});

  @override
  State<Network_Screen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<Network_Screen> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition GooglePlex =
      CameraPosition(target: LatLng(24.9380, 67.0479), zoom: 14);

  final Set<Marker> _marker = {};

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
    loadData();
  }

  loadData() async {
    for (int i = 0; i < 5; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://cdn-icons-png.flaticon.com/128/4807/4807598.png');
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image.buffer.asUint8List(),
          targetHeight: 100,
          targetWidth: 100);

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          infoWindow: InfoWindow(title: 'hehe boi' + i.toString())));
      setState(() {});
    }
  }

  Future<Uint8List> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image =
        NetworkImage('https://cdn-icons-png.flaticon.com/128/4807/4807598.png');

    image.resolve(ImageConfiguration(size: Size.fromHeight(10))).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));

    final imageInfo = await completer.future;
    final ByteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return ByteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: GooglePlex,
            markers: Set<Marker>.of(_marker),
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
      ),
    );
  }
}
