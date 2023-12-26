import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomStyleGoogleMap extends StatefulWidget {
  const CustomStyleGoogleMap({super.key});

  @override
  State<CustomStyleGoogleMap> createState() => _CustomStyleGoogleMapState();
}

class _CustomStyleGoogleMapState extends State<CustomStyleGoogleMap> {
  String Maptheme = " ";
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(24.9380, 67.0479), zoom: 14);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/nighttheme.json')
        .then((value) {
      Maptheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Map Theme")),
        actions: [
          PopupMenuButton(
              itemBuilder: ((context) => [
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/silvertheme.json')
                                .then((String) {
                              value.setMapStyle(String);
                            });
                          });
                        },
                        child: Text('Silver')),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/nighttheme.json')
                                .then((String) {
                              value.setMapStyle(String);
                            });
                          });
                        },
                        child: Text('Night')),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/retrotheme.json')
                                .then((String) {
                              value.setMapStyle(String);
                            });
                          });
                        },
                        child: Text('Retro')),
                  ]))
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(Maptheme);
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
