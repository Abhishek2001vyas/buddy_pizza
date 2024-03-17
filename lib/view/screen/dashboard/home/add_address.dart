import 'dart:async';
import 'dart:convert';

import 'package:buddy_pizza/view/screen/dashboard/home/map_screen.dart';
import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AddAddress extends StatefulWidget {
  final goto;

  const AddAddress({super.key, required this.goto});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  var _controllers = TextEditingController();
  var uuid = Uuid();
  String k = "d90alvgHTQ-yYTKGJhxPch:"
      "APA91bGQCKn93TPFsEil_meZ4axhd3ywiBNAy2tijOJOtqC"
      "0EFVGJobF6hrde6DGNOEhH05CWUI-HFKfgtFI0gxIBIQ2gPmIJv"
      "8QrM8UsHE_SIIuFf84fMg_M99iurPIn6dL30XZiu84";
  List<dynamic> _placeList = [];
  String tappedPlace = "";
  Completer<GoogleMapController> _controller = Completer();
  Timer? _debounce;
  String? address;

  @override
  void initState() {
    super.initState();
    _controllers.addListener(() {
      _onChanged();
    });

    // _getTappedPlace();
  }

  LatLng? showLocation;

/*
  Future<void> getLocationFromPlaceName(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;

        // Save the latitude and longitude to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setDouble('latitude', latitude);
        await prefs.setDouble('longitude', longitude);

        print('Latitudegmapc: $latitude, Longitudegmapc: $longitude');
      } else {
        print('No results found for the provided place name.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
*/

  _onChanged() {
    if (k == null) {
      setState(() {
        k = uuid.v4();
      });
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getSuggestion(_controllers.text);
    });
  }

  void getSuggestion(String input) async {
    try {
      String kPLACES_API_KEY =
          "AIzaSyC85iTCGYU-pIeS9fp1agTcHYWjS5XgaxY&libraries=places";
      String type = '(regions)';
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$k';
      var response = await http.get(Uri.parse(request)); // Use Uri.parse here
      if (response.statusCode == 200) {
        print("hhhhhhhhu${json.decode(response.body)}");
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
        print("oooooooo${_placeList[0]["types"]}");
      } else {
        print(
            'Failed to load predictions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getLocationFromPlaceName(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;
        Get.to(() => MapScreen(
              lat: locations.first.latitude,
              lon: locations.first.longitude,
              goto: widget.goto,
            ));

        print("jjjj${placeName}${locations.first.latitude}");
        final GoogleMapController controller = await _controller.future;
        await controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(latitude, longitude), zoom: 16)));

        setState(() {
          showLocation = LatLng(latitude, longitude);
        });
        print("kkm;jm${showLocation.toString()}");
        print('Latitudegmapc: $latitude, Longitudegmapc: $longitude');
      } else {
        print('No results found for the provided place name.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // _getTappedPlace() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     tappedPlace = prefs.getString('tappedPlace') ?? "";
  //   });
  // }

  // _setTappedPlace(String value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('tappedPlace', value);
  // }

  // Widget _location() {
  //   return Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: InkWell(
  //       onTap: () {
  //         setState(() {
  //           _currentLocation();
  //         });
  //       },
  //       child: Container(
  //         width: 40,
  //         height: 40,
  //         padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //         ),
  //         child: ClipOval(
  //           child: Image.asset(
  //             "assets/image/target.png",
  //             fit: BoxFit.cover,
  //             color: Colors.grey.shade700,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          "Address",
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _controllers,
                  decoration: InputDecoration(
                    hintText: "search location",
                    focusColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: _controllers.text.toString() == ""
                        ? null
                        : IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _controllers.clear();
                            },
                          ),
                    border: InputBorder.none, // Remove the underline
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  double latitude = position.latitude;
                  double longitude = position.longitude;
                  Get.to(() => MapScreen(
                        lat: latitude,
                        lon: longitude,
                        goto: widget.goto,
                      ));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.green.shade700,
                    ),
                    Text(
                      "Use my current location",
                      style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              // Set your desired background color here
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  final place = _placeList[index];

                  return ListTile(
                    title: InkWell(
                      onTap: () async {
                        final placeid = place["place_id"];
                        final description = place["description"];
                        print('Tapped place..... $description');
                        try {
                          print("uuuuu$placeid");
                          await getLocationFromPlaceName(description);
                          setState(() {
                            tappedPlace = description;
                            _controllers.clear();
                          });
                        } catch (e) {
                          print('Error: $e');
                        }
                      },
                      child: Text(
                        place["description"],
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  );
                },
              ),
            ),
          ])),
    );
  }
}
