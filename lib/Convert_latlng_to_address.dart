import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Conversion extends StatefulWidget {
  const Conversion({super.key});

  @override
  State<Conversion> createState() => _ConversionState();
}

class _ConversionState extends State<Conversion> {
  String stcoordinate = " ";
  String stadress = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(stcoordinate),
          Text(stadress),
          GestureDetector(
            onTap: () async {
              List<Location> locations =
                  await locationFromAddress("South Korea   ");
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(34.1186, 71.1567);

              setState(() {
                stcoordinate = 'lat:' +
                    locations.last.latitude.toString() +
                    "   " +
                    'Lng:' +
                    locations.last.longitude.toString();
                stadress = placemarks.reversed.last.country.toString() +
                    " " +
                    placemarks.last.locality.toString() +
                    " " +
                    placemarks.last.subAdministrativeArea.toString();
              });
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Center(child: Text('Convert')),
            ),
          )
        ],
      ),
    );
  }
}
