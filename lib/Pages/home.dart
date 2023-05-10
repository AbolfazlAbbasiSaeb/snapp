import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:snapp/Pages/LoginPage.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OpenStreetMap',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  String _address = 'تهران,میدان آزادی'; //آدرس دیفالت
  String APIKey = 'service.c9a6418b1e1f44799ec873e02674c6e9';  // توکن دریافتی از سایت نشان
  Future<void> _getAddress(LatLng latLng) async {
    final apiKey = 'f0706cf12f83a805b7dd400cf70dd63b';
    final url =
        'https://api.neshan.org/v5/reverse?lat=${latLng.latitude}&lng=${latLng.longitude}';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Api-Key': APIKey,
      },
    );
    final bodyBytes = response.bodyBytes;
    final responseBody = utf8.decode(bodyBytes);
    final results = jsonDecode(responseBody)['formatted_address'];
    if (results.isNotEmpty) {
      final address = results;
      setState(() {
        _address = address;
      });
    }
  }

  @override
  LatLng _center = LatLng(35.6997, 51.3380); // مختصات دیفالت میدان آزادی تهران
  final Location _location = Location();
  final MapController _mapController = MapController();
  void _getCurrentLocation() async {
    try {
      LocationData locationData = await _location.getLocation();
      setState(() {
        _center = LatLng(locationData.latitude!, locationData.longitude!);
      });
      _mapController.move(_center, 16.0);
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: _center,
          zoom: 17.0,
          onTap: (tapPosition, point) {
            setState(() {
              _center = point!;
            });
            _getAddress(point);
          },
        ),
        mapController: _mapController,
        nonRotatedChildren: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(Icons.account_circle_outlined, size: 30),
                        ),
                        Container(
                          width: 180,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 90,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Text(
                                      'برای دیگران',
                                      style: TextStyle(
                                          package: 'persian_fonts',
                                          fontFamily: 'Vazir',
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Text(
                                      'برای خودم',
                                      style: TextStyle(
                                          package: 'persian_fonts',
                                          fontFamily: 'Vazir',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(LoginPage()),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Icon(Icons.home, size: 30),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: _getCurrentLocation,
                          tooltip: 'Get Current Location',
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.location_on,color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width: 590,
                      height: 60,
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        ' $_address',
                        style: const TextStyle(
                            package: 'persian_fonts',
                            fontFamily: 'Vazir',
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            // subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _center,
                width: 130,
                height: 130,
                builder: (context) => Image.asset("assets/piin.png"),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            height: 55,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: const Center(
              child: Text(
                'تایید مبدا',
                style: TextStyle(
                    package: 'persian_fonts',
                    fontFamily: 'Vazir',
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
