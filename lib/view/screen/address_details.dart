import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../api/address.dart';
import '../theme/text2.dart';

class AddressDetails extends StatefulWidget {
  final double lat;
  final double lon;
  final goto;

  const AddressDetails(
      {super.key, required this.lat, required this.lon, required this.goto});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final addaddress = Get.put(Address_api());
  LatLng? center;

  @override
  void initState() {
    super.initState();
    setState(() {
      center = LatLng(widget.lat, widget.lon);
    });
  }

  LatLng? _currentLocation;

  late GoogleMapController _controller;

  // String _city = '';
  // static final CameraPosition _initialPosition = CameraPosition(
  //   target: LatLng(37.422, -122.084), // Default location (Googleplex)
  //   zoom: 14.0,
  // );

  TextEditingController houseno = TextEditingController();
  TextEditingController floorno = TextEditingController();
  TextEditingController buildingno = TextEditingController();
  TextEditingController howtoreach = TextEditingController();
  TextEditingController mobileno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Address Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: h / 3,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: center!,
                  zoom: 13.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                markers: {
                  Marker(
                    markerId: MarkerId('current_location'),
                    position: center!,
                    infoWindow: const InfoWindow(
                      title: 'Current Location',
                      snippet: 'This is your current location',
                    ),
                  ),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: houseno,
                    decoration: const InputDecoration(
                      labelText: '*House/Flat no', // Placeholder text
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 2)), // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: floorno,
                    decoration: const InputDecoration(
                      labelText: 'Floor number', // Placeholder text
                      border: OutlineInputBorder(), // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: buildingno,
                    decoration: const InputDecoration(
                      labelText:
                          'Apartment / Building name', // Placeholder text
                      border: OutlineInputBorder(), // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: howtoreach,
                    decoration: const InputDecoration(
                      labelText: 'How to reach (Optional', // Placeholder text
                      border: OutlineInputBorder(), // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                  TextField(
                    controller: mobileno,
                    decoration: const InputDecoration(
                      labelText: 'Contact number (Optional', // Placeholder text
                      border: OutlineInputBorder(), // Border style
                    ),
                  ),
                  SizedBox(
                    height: h / 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: () async {
              addaddress.Addaddressapi(
                  houseno.text.toString(),
                  floorno.text.toString(),
                  buildingno.text.toString(),
                  howtoreach.text.toString(),
                  mobileno.text.toString(),
                  center!.latitude.toString(),
                  center!.longitude.toString(),
                  widget.goto);
              // Get.to(() => AddressDetails());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text('Confirm Location', style: A_style_text_inside_button),
          ),
        ),
      ),
    );
  }
}
