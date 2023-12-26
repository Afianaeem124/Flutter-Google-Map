import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindowScreen extends StatefulWidget {
  const CustomInfoWindowScreen({super.key});

  @override
  State<CustomInfoWindowScreen> createState() => _CustomInfoWindowState();
}

class _CustomInfoWindowState extends State<CustomInfoWindowScreen> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latlng = <LatLng>[
    LatLng(24.9380, 67.0479),
    LatLng(24.8825, 67.0694),
    LatLng(24.9389, 67.1237),
    LatLng(24.9729, 67.0643),
    LatLng(25.0351, 67.1406),
    LatLng(24.7906, 67.0404)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latlng.length; i++) {
      if (i % 2 == 0) {
        _marker.add(Marker(
            markerId: MarkerId('2'),
            position: LatLng(33.6992, 72.9744),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "I am here",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const LatLng(33.6992, 72.9744),
              );
            }));
      } else {
        _marker.add(Marker(
          markerId: MarkerId(
            (i + 1).toString(),
          ),
          position: _latlng[i],
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        'https://images.pexels.com/photos/954677/pexels-photo-954677.jpeg?auto=compress&cs=tinysrgb&w=600'),
                                    fit: BoxFit.fitWidth,
                                    filterQuality: FilterQuality.high)),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Beef Tacos',
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ),
                                const Spacer(),
                                Text('Woowww Yummm'
                                    // widget.data!.date!,
                                    ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Text(
                              'Help me finish these tacos! I got a platter from Costco and it’s too much.',
                              maxLines: 2,
                            ),
                          ),
                        ])),
                _latlng[i]);
          },
        ));
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(24.9380, 67.0479), zoom: 14),
            markers: Set<Marker>.of(_marker),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!;
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
