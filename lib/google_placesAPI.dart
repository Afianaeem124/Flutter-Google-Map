import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlaces extends StatefulWidget {
  GooglePlaces({super.key});

  @override
  State<GooglePlaces> createState() => _GooglePlacesState();
}

class _GooglePlacesState extends State<GooglePlaces> {
  final TextEditingController _controller = TextEditingController();
  var uuid = Uuid();

  String sessiontoken = '12345';
  List<dynamic> placeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (sessiontoken == null) {
      setState(() {
        sessiontoken = uuid.v4();
      });
    }
    getsuggestion(_controller.text);
  }

  void getsuggestion(String input) async {
    String kPLACES_Api_Key = 'AIzaSyAts-pZxMgIKDHRoU67Yb6S8pg22rrRsoo';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_Api_Key&sessiontoken=$sessiontoken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        placeList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('google places api'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Search places with name ',
                  prefixIcon: Icon(Icons.map),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      icon: Icon(Icons.cancel))),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: placeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(placeList[index]['description']));
                    }))
          ],
        ),
      ),
    );
  }
}
