import 'package:buddy_pizza/view/screen/dashboard/profile/profile_details/profile_screen.dart';
import 'package:buddy_pizza/view/theme/color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/Addtocart_api.dart';
import '../../../api/address.dart';
import '../../../api/homebanner_api.dart';
import '../../../api/hotdeals_api.dart';
import '../../../api/subcategorieslist_api.dart';
import '../../../theme/text2.dart';
import '../../../utils/constant.dart';
import '../../custom_indicator.dart';
import '../add_cart.dart';
import '../menu_screen.dart';
import 'add_address.dart';
import 'order_detailsforhot.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final hotdealapi = Get.put(hotdeal_api());
  final cartlistapi = Get.put(Addtocart_api());
  final getaddress = Get.put(Address_api());
  final banner = Get.put(homebanner_api());
  @override
  void initState() {
    saveAddressToSharedPreferences();
    getCurrentLocation();
    super.initState();
  }

var userno;


  Set<Marker> markers = Set();
  LatLng? showLocation;
  String address = "Address not found ";
  int currentIndex = 0;
  late LatLng currentLocation;
  String currentAddress = '';
  late LatLng currentLocation1;
  String currentCity = "";
  List dropdownvalue =[];
    //  "BBQ(Mild)";

  void saveAddressToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userno=prefs.getString("userno");
    });}

  LatLng get currentLocation0 => currentLocation1;

  Future<void> getCurrentLocation() async {
    print("Get Current Location");
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        locationPermission();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> locationPermission() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentLocation = LatLng(position.latitude, position.longitude);
    setState(() {});

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address =
          '${placemark.subLocality}, ${placemark.locality}\n${placemark.administrativeArea}, ${placemark.country}';
      String city = "${placemark.locality}";
      currentCity = city;
      currentAddress = address;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: Row(
            children: [
              Image.asset(
                "assets/images/img.png",
                scale: 3,
                height: h / 19,
              ),
SizedBox(width: w/200,),
              SizedBox(
                width: w / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userno??"",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          // fontFamily: "Amazon_med",
                          fontSize: 16),
                      maxLines: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AddAddress(
                              goto: 0,
                            ));
                      },
                      child: Row(
                        children: [
                          FutureBuilder(
                            future: getaddress.Addresslistapi(),
                            builder: (context, snapshot) {
                              return Addresslist.isNotEmpty
                                  ?  SizedBox(
                                width: w / 2.5,
                                child: Text(
                                   style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis,
                                    // fontFamily: "Amazon_med",
                                    fontSize: 14),
                                  maxLines: 1,
        
                                    "${Addresslist[0]["house_no"]}, ${Addresslist[0]["floor_no"]},${Addresslist[0]["building_name"]},${Addresslist[0]["how_to_reach"]},${Addresslist[0]["contact_no"]}"),
                              )
                                  : Text(
                                '${currentAddress}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis,
                                    // fontFamily: "Amazon_med",
                                    fontSize: 14),
                                maxLines: 1,
                              );
                            },
                          ),
        
        
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   selectedIndex=3;
                  // });
        
                  Get.to(() => ProfileScreen());
                },
                child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade200, blurRadius: 3)
                        ]),
                    child:
                        FutureBuilder(future: banner.loyalty(), builder: (context, snapshot) {
                          return Text(
                            "${loyaltypoint[0]} Points",
                            style: verySmallText,
                          );
                        },)
                    ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () async {
                  await cartlistapi.Addtocartist();
                  Get..to(() => const CartScreen());
                },
                child:
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(height: 70,width: 30,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: SvgPicture.asset(
                            "assets/images/carticon.svg",
                            height: 25,
                          ),
                        ),


                        Positioned(right: 1,top: 15,
                          child: StreamBuilder(
                            stream: Stream.periodic(Duration(seconds: 0))
                                .asyncMap((i) =>  cartlistapi.Addtocartist()),

                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              return
                                cartlistapi.cartlist.isNotEmpty?
                                Container(decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red
                                ),
                                  height: 18,width: 18,
                                  child: Center(
                                    child: Text("${
                                        cartlistapi.cartlist .elementAt(0)[0]["products"]
                                            .length
                                    }",style: TextStyle(color: Colors.white,fontSize: 13),
                                    ),
                                  ),):Text("");
                            },),


                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sliderimage.isNotEmpty
                ? Container(
                    child: CarouselSlider.builder(
                        itemCount: sliderimage.elementAt(0).length,
                        itemBuilder: (context, index, realIndex) => Center(
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 2,
                                child: Container(
                                    width: w / 1.1,
                                    height: h / 3.5,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff0e18cf)
                                            .withOpacity(.8),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            "${user_image_url}${sliderimage.elementAt(0)[index]["banner_image"]}"))),
                              ),
                            ),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          height: h / 3.5,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 16,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 1,
                        )),
                  )
                : SizedBox(),
            SizedBox(
              height: h / 80,
            ),
            CustomIndicator(
              currentIndex: currentIndex,
              itemCount: sliderimage.elementAt(0).length,
            ),
            SizedBox(
              height: h / 80,
            ),
            SizedBox(
              height: h / 5.5,
              child: FutureBuilder(
                future: null,
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: cate.elementAt(0).length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  menuItemList = index;
                                });

                                Get.to(() => MenuScreen());
                              },
                              child: Container(
                                width: w / 5,
                                height: h / 14,
                                margin: const EdgeInsets.all(4),
                                // padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 3)
                                    ]),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                        fit: BoxFit.fill,
                                        "${user_image_url}${cate.elementAt(0)[index]["category_logo"]}")),
                              ),
                            ),
                            SizedBox(
                              height: h / 100,
                            ),
                            Text(
                              cate.elementAt(0)[index]["category_name"],
                              style: A_style_mid,
                            )
                          ],
                        );
                      });
                },
              ),
            ),
            SizedBox(
              height: h / 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hot deals",
                  style: Text_Lit_Bold,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => MenuScreen());
                  },
                  child: Text(
                    "View deals",
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      //  fontFamily: "Ember"
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: h / 80,
            ),
            FutureBuilder(future: hotdealapi.hotdeals1(),
                builder: (context, snapshot) {

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,itemCount:hot.elementAt(0).length,
                    itemBuilder: (context, index) {
                      print("category_name${hot.elementAt(0)[index]["categoryId"]["category_name"]}");
                      dropdownvalue= List.filled(hot.elementAt(0).length, wingflavourlist[0]);
                    return hot.isEmpty
                           ? Text("No Hot deals available"):
                    hot.elementAt(0)[index]["wings_drinks"].isNotEmpty?
                    Column(
                      children: [
                        Stack(children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => OrderDetails1(
                                index: index,
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              width: w / 1.043,
                              height: h / 3.5,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image:
                                    hot.elementAt(0)[index]["product_image"]==null || hot.elementAt(0)[index]["product_image"]==""?
                                    NetworkImage(
                                      "${user_image_url}${hot.elementAt(0)[index]["categoryId"]["category_logo"]}",
                                    ):
                                    NetworkImage(
                                      "${user_image_url}${hot.elementAt(0)[index]["product_image"]}",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: w / 1.043,
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      // Color(0xff08080863),
                                      // Color(0xff080808)
                                      Color(0xff08080863),
                                      Colors.black,
                                    ]),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: h / 30,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["product_name"],
                                    style: TextBold,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["description"],
                                    style: const TextStyle(
                                      //letterSpacing: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        color: Colors.white,

                                        //  fontFamily: "Amazon_med",
                                        fontSize: 14),
                                    maxLines: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      // Text(
                                      //   "CAD ${hot.elementAt(0)[index]["price"]}",
                                      //   style: TextBold,
                                      // ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(() =>
                                          // const YourOrder());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 8,
                                              vertical: 2),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(
                                                5),
                                          ),
                                          child: Text(
                                            "Order Now",
                                            style: Text_inside_button,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: h / 80,
                        ),
                      ],
                    ):
                    hot.elementAt(0)[index]["size_name"].isNotEmpty?
                    Column(
                      children: [
                        Stack(children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => OrderDetails1(
                                index: index,
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              width: w / 1.043,
                              height: h / 3.5,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${user_image_url}${hot.elementAt(0)[index]["product_image"]}",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: w / 1.043,
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      // Color(0xff08080863),
                                      // Color(0xff080808)
                                      Color(0xff08080863),
                                      Colors.black,
                                    ]),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: h / 30,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["product_name"],
                                    style: TextBold,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["description"],
                                    style: const TextStyle(
                                      //letterSpacing: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        color: Colors.white,

                                        //  fontFamily: "Amazon_med",
                                        fontSize: 14),
                                    maxLines: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      // Text(
                                      //   "CAD ${hot.elementAt(0)[index]["purchase_price"]}",
                                      //   style: TextBold,
                                      // ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(() =>
                                          // const YourOrder());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 8,
                                              vertical: 2),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(
                                                5),
                                          ),
                                          child: Text(
                                            "Order Now",
                                            style: Text_inside_button,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: h / 80,
                        ),
                      ],
                    ):
                    hot.elementAt(0)[index]["categoryId"]["category_name"]=="Wings"?
                    Column(
                      children: [
                        Stack(children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => OrderDetails1(
                                index: index,
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              width: w / 1.043,
                              height: h / 3.5,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image:
                      hot.elementAt(0)[index]["product_image"]==null || hot.elementAt(0)[index]["product_image"]==""?
                      NetworkImage(
                        "${user_image_url}${hot.elementAt(0)[index]["categoryId"]["category_logo"]}",
                      ):
                                    NetworkImage(
                                      "${user_image_url}${hot.elementAt(0)[index]["product_image"]}",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: w / 1.043,
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      // Color(0xff08080863),
                                      // Color(0xff080808)
                                      Color(0xff08080863),
                                      Colors.black,
                                    ]),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: h / 30,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["product_name"]??"",
                                    style: TextBold,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["description"]??"",
                                    style: const TextStyle(
                                      //letterSpacing: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        color: Colors.white,

                                        //  fontFamily: "Amazon_med",
                                        fontSize: 14),
                                    maxLines: 1,
                                  ),
                                  Container(
                                    width: w / 1,
                                    padding:
                                    const EdgeInsets
                                        .only(
                                        top: 5,
                                        left: 10,
                                        right: 10,
                                        bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10),
                                        border: Border.all(
                                            color: Colors
                                                .white,
                                            width: 1)),
                                    child:
                                    DropdownButton(
                                      underline:
                                      const SizedBox(),
                                      
                                      // Initial Value
                                      value:dropdownvalue.length > index ? dropdownvalue[index] : null,
                                      hint: Text(
                                          'select',style: TextStyle(color: Colors.white)),
                                      isExpanded: true,
                                      // Down Arrow Icon
                                      icon: const Icon(
                                          Icons
                                              .keyboard_arrow_down,
                                          color: Colors
                                              .red),

                                      // Array list of items
                                      items: wingflavourlist
                                          .map((String
                                      items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                              items,),
                                        );
                                      }).toList(),

                                      onChanged: (
                                      newValue) {
                                        setState(() {
                                          print("${newValue}");
                                          dropdownvalue[index]="${newValue}";
                                          print("${dropdownvalue[index]}");
                                          
                                         // dropdownvalue.insert(3,"${newValue ?? ''}");
                                         // [index] = {index: newValue ?? ''};
                                              // newValue ??
                                              //     "";
                                        });

                                        print("dropdown44${dropdownvalue}");
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: h / 80,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "CAD ${hot.elementAt(0)[index]["price"]}",
                                        style: TextBold,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(() =>
                                          // const YourOrder());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 8,
                                              vertical: 2),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(
                                                5),
                                          ),
                                          child: Text(
                                            "Order Now",
                                            style: Text_inside_button,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: h / 80,
                        ),
                      ],
                    ):
                    Column(
                      children: [
                        Stack(children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => OrderDetails1(
                                index: index,
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              width: w / 1.043,
                              height: h / 3.5,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image:
                                    hot.elementAt(0)[index]["product_image"]==null || hot.elementAt(0)[index]["product_image"]==""?
                                    NetworkImage(
                                      "${user_image_url}${hot.elementAt(0)[index]["categoryId"]["category_logo"]}",
                                    ):
                                    NetworkImage(
                                      "${user_image_url}${hot.elementAt(0)[index]["product_image"]}",
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: w / 1.043,
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      // Color(0xff08080863),
                                      // Color(0xff080808)
                                      Color(0xff08080863),
                                      Colors.black,
                                    ]),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: h / 30,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["product_name"]??"",
                                    style: TextBold,
                                  ),
                                  Text(
                                    hot.elementAt(0)[index]
                                    ["description"]??"",
                                    style: const TextStyle(
                                      //letterSpacing: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        color: Colors.white,

                                        //  fontFamily: "Amazon_med",
                                        fontSize: 14),
                                    maxLines: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "CAD ${hot.elementAt(0)[index]["price"]}",
                                        style: TextBold,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(() =>
                                          // const YourOrder());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 8,
                                              vertical: 2),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(
                                                5),
                                          ),
                                          child: Text(
                                            "Order Now",
                                            style: Text_inside_button,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: h / 80,
                        ),
                      ],
                    )
                    ;
                  },);
                },),
            // ListView.builder(
            //   shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index1) {
            //     //print("poiu ${hot.elementAt(0)[0]["size_name"]}");
            //   return   hot.isEmpty
            //       ? Text("No Hot deals available")
            //       : hot.elementAt(0)[0]["size_name"].isEmpty
            //   // &
            //   // hot.elementAt(0)[index1]["wings_drinks"].isEmpty
            //       ? Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //           width: w,
            //           height: h / 3,
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(5),
            //             child: Image.network(
            //                 fit: BoxFit.fill,
            //                 "${user_image_url}${cate.elementAt(0)[0]["category_logo"]}"),
            //           )),
            //       SizedBox(
            //         height: h / 70,
            //       ),
            //       // Text(
            //       //     cate.elementAt(0)[menuItemList]
            //       //             ["category_name"] ??
            //       //         "",
            //       //     style: Text_Lit_Bold),
            //       SizedBox(
            //         height: h / 70,
            //       ),
            //       hot.elementAt(0)[0]["wings_drinks"].isEmpty
            //           ? ListView.builder(
            //         physics: NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: hot.elementAt(0).length,
            //         itemBuilder: (context, index) {
            //           return Theme(
            //             data: Theme.of(context).copyWith(
            //                 dividerColor: Colors.transparent),
            //             child: ExpansionTile(
            //                 tilePadding: EdgeInsets.all(0),
            //                 iconColor: Colors.black,
            //                 title: Text(
            //                     '${hot.elementAt(0)[index]["product_name"]}  CAD${hot.elementAt(0)[index]["price"]} ',
            //                     style: A_style_medium),
            //                 expandedCrossAxisAlignment:
            //                 CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     hot.elementAt(0)[0]
            //                     ["description"],
            //                   ),
            //                   SizedBox(
            //                     height: h / 90,
            //                   ),
            //                   GetBuilder<PizzaController>(
            //                       builder: (PizzaController
            //                       controller) {
            //                         return Container(
            //                           decoration: BoxDecoration(
            //                               color: Colors.white,
            //                               borderRadius:
            //                               BorderRadius
            //                                   .circular(20),
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                     color: Colors.grey
            //                                         .shade300,
            //                                     blurRadius: 3)
            //                               ]),
            //                           child: Row(
            //                             mainAxisAlignment:
            //                             MainAxisAlignment
            //                                 .spaceBetween,
            //                             children: [
            //                               InkWell(
            //                                 onTap: () {
            //                                   controller
            //                                       .decrement();
            //                                 },
            //                                 child: Container(
            //                                     width: 40,
            //                                     decoration:
            //                                     const BoxDecoration(
            //                                       color: Colors
            //                                           .black,
            //                                       borderRadius: BorderRadius.only(
            //                                           topLeft: Radius
            //                                               .circular(
            //                                               20),
            //                                           bottomLeft:
            //                                           Radius.circular(
            //                                               20)),
            //                                     ),
            //                                     child: const Text(
            //                                       "-",
            //                                       style: TextStyle(
            //                                           fontSize:
            //                                           25,
            //                                           color: Colors
            //                                               .white,
            //                                           fontWeight:
            //                                           FontWeight
            //                                               .bold),
            //                                       textAlign:
            //                                       TextAlign
            //                                           .center,
            //                                     )),
            //                               ),
            //                               Text(
            //                                 "QTy:${controller.counter}",
            //                                 style:
            //                                 const TextStyle(
            //                                     color: Colors
            //                                         .black),
            //                               ),
            //                               InkWell(
            //                                 onTap: () {
            //                                   controller
            //                                       .increment();
            //                                 },
            //                                 child: Container(
            //                                     width: 40,
            //                                     decoration:
            //                                     const BoxDecoration(
            //                                       color: Colors
            //                                           .black,
            //                                       borderRadius: BorderRadius.only(
            //                                           topRight: Radius
            //                                               .circular(
            //                                               20),
            //                                           bottomRight:
            //                                           Radius.circular(
            //                                               20)),
            //                                     ),
            //                                     child: const Text(
            //                                       "+",
            //                                       style: TextStyle(
            //                                           fontSize:
            //                                           25,
            //                                           color: Colors
            //                                               .white,
            //                                           fontWeight:
            //                                           FontWeight
            //                                               .bold),
            //                                       textAlign:
            //                                       TextAlign
            //                                           .center,
            //                                     )),
            //                               )
            //                             ],
            //                           ),
            //                         );
            //                       }),
            //                   SizedBox(
            //                     height: h / 80,
            //                   ),
            //                   InkWell(
            //                     onTap: () {
            //                       Get.to(() =>
            //                       const YourOrder());
            //                     },
            //                     child: Container(
            //                       width: w,
            //                       padding: EdgeInsets.all(8),
            //                       decoration: BoxDecoration(
            //                           color: Colors.black,
            //                           borderRadius:
            //                           BorderRadius
            //                               .circular(20)),
            //                       child: Text(
            //                         "Add to Order",
            //                         style: TextBold,
            //                         textAlign:
            //                         TextAlign.center,
            //                       ),
            //                     ),
            //                   )
            //                 ]),
            //           );
            //         },
            //       )
            //           : ListView.builder(
            //         physics: NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: hot.elementAt(0).length,
            //         itemBuilder: (context, index) {
            //           return Theme(
            //             data: Theme.of(context).copyWith(
            //                 dividerColor: Colors.transparent),
            //             child: ExpansionTile(
            //                 tilePadding: EdgeInsets.all(0),
            //                 iconColor: Colors.black,
            //                 title: Text(
            //                     '${hot.elementAt(0)[index]["product_name"]}  ',
            //                     style: A_style_medium),
            //                 expandedCrossAxisAlignment:
            //                 CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     hot.elementAt(0)[0]
            //                     ["description"],
            //                   ),
            //                   SizedBox(
            //                     height: h / 90,
            //                   ),
            //                   ListView.builder(
            //                     shrinkWrap: true,
            //                     itemCount: hot
            //                         .elementAt(0)[0]
            //                     ["wings_drinks"]
            //                         .length,
            //                     itemBuilder:
            //                         (context, index) {
            //                       return GetBuilder<
            //                           PizzaController>(
            //                           builder:
            //                               (PizzaController
            //                           controller) {
            //                             return Row(
            //                               children: [
            //                                 SizedBox(
            //                                     width: w / 30),
            //                                 SizedBox(
            //                                     width: w / 3,
            //                                     child: Text(
            //                                         "${hot.elementAt(0)[0]["wings_drinks"][index]["quantitiy"]} - CAD${hot.elementAt(0)[0]["wings_drinks"][index]["price"]} ")),
            //                                 Padding(
            //                                   padding:
            //                                   const EdgeInsets
            //                                       .only(
            //                                       top: 8.0,
            //                                       bottom: 8),
            //                                   child: Container(
            //                                     width: w / 3,
            //                                     decoration: BoxDecoration(
            //                                         color: Colors
            //                                             .white,
            //                                         borderRadius:
            //                                         BorderRadius
            //                                             .circular(20),
            //                                         boxShadow: [
            //                                           BoxShadow(
            //                                               color: Colors
            //                                                   .grey
            //                                                   .shade300,
            //                                               blurRadius:
            //                                               3)
            //                                         ]),
            //                                     child: Row(
            //                                       mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                       children: [
            //                                         InkWell(
            //                                           onTap: () {
            //                                             controller
            //                                                 .decrement();
            //                                           },
            //                                           child: Container(
            //                                               width: 40,
            //                                               decoration: const BoxDecoration(
            //                                                 color:
            //                                                 Colors.black,
            //                                                 borderRadius: BorderRadius.only(
            //                                                     topLeft: Radius.circular(20),
            //                                                     bottomLeft: Radius.circular(20)),
            //                                               ),
            //                                               child: const Text(
            //                                                 "-",
            //                                                 style: TextStyle(
            //                                                     fontSize: 25,
            //                                                     color: Colors.white,
            //                                                     fontWeight: FontWeight.bold),
            //                                                 textAlign:
            //                                                 TextAlign.center,
            //                                               )),
            //                                         ),
            //                                         Text(
            //                                           "QTy:${controller.counter}",
            //                                           style: const TextStyle(
            //                                               color: Colors
            //                                                   .black),
            //                                         ),
            //                                         InkWell(
            //                                           onTap: () {
            //                                             controller
            //                                                 .increment();
            //                                           },
            //                                           child: Container(
            //                                               width: 40,
            //                                               decoration: const BoxDecoration(
            //                                                 color:
            //                                                 Colors.black,
            //                                                 borderRadius: BorderRadius.only(
            //                                                     topRight: Radius.circular(20),
            //                                                     bottomRight: Radius.circular(20)),
            //                                               ),
            //                                               child: const Text(
            //                                                 "+",
            //                                                 style: TextStyle(
            //                                                     fontSize: 25,
            //                                                     color: Colors.white,
            //                                                     fontWeight: FontWeight.bold),
            //                                                 textAlign:
            //                                                 TextAlign.center,
            //                                               )),
            //                                         )
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             );
            //                           });
            //                     },
            //                   ),
            //                   SizedBox(
            //                     height: h / 80,
            //                   ),
            //                   InkWell(
            //                     onTap: () {
            //                       Get.to(() =>
            //                       const YourOrder());
            //                     },
            //                     child: Container(
            //                       width: w,
            //                       padding: EdgeInsets.all(8),
            //                       decoration: BoxDecoration(
            //                           color: Colors.black,
            //                           borderRadius:
            //                           BorderRadius
            //                               .circular(20)),
            //                       child: Text(
            //                         "Add to Order",
            //                         style: TextBold,
            //                         textAlign:
            //                         TextAlign.center,
            //                       ),
            //                     ),
            //                   )
            //                 ]),
            //           );
            //         },
            //       )
            //     ],
            //   )
            //       : Column(
            //     children: [
            //       Stack(children: [
            //         GestureDetector(
            //           onTap: () {
            //             Get.to(() => OrderDetails1(
            //               index: index1,
            //             ));
            //           },
            //           child: Container(
            //             margin: const EdgeInsets.all(3),
            //             width: w / 1.043,
            //             height: h / 3.5,
            //             decoration: BoxDecoration(
            //                 borderRadius:
            //                 BorderRadius.circular(8),
            //                 image: DecorationImage(
            //                   image: NetworkImage(
            //                     "${user_image_url}${hot.elementAt(0)[index1]["product_image"]}",
            //                   ),
            //                   fit: BoxFit.cover,
            //                 )),
            //           ),
            //         ),
            //         Positioned(
            //           bottom: 0,
            //           child: Container(
            //             width: w / 1.043,
            //             margin: const EdgeInsets.all(3),
            //             padding: const EdgeInsets.all(10),
            //             decoration: const BoxDecoration(
            //               gradient: LinearGradient(
            //                   begin: Alignment.topCenter,
            //                   end: Alignment.bottomCenter,
            //                   colors: [
            //                     // Color(0xff08080863),
            //                     // Color(0xff080808)
            //                     Color(0xff08080863),
            //                     Colors.black,
            //                   ]),
            //               borderRadius: BorderRadius.only(
            //                   bottomRight: Radius.circular(8),
            //                   bottomLeft: Radius.circular(8)),
            //             ),
            //             child: Column(
            //               crossAxisAlignment:
            //               CrossAxisAlignment.start,
            //               children: [
            //                 SizedBox(
            //                   height: h / 30,
            //                 ),
            //                 Text(
            //                   hot.elementAt(0)[index1]
            //                   ["product_name"],
            //                   style: TextBold,
            //                 ),
            //                 Text(
            //                   hot.elementAt(0)[index1]
            //                   ["description"],
            //                   style: const TextStyle(
            //                     //letterSpacing: 2,
            //                       overflow:
            //                       TextOverflow.ellipsis,
            //                       color: Colors.white,
            //
            //                       //  fontFamily: "Amazon_med",
            //                       fontSize: 14),
            //                   maxLines: 1,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment:
            //                   MainAxisAlignment.end,
            //                   children: [
            //                     // Text(
            //                     //   "CAD ${hot.elementAt(0)[index]["purchase_price"]}",
            //                     //   style: TextBold,
            //                     // ),
            //                     GestureDetector(
            //                       onTap: () {
            //                         // Get.to(() =>
            //                         // const YourOrder());
            //                       },
            //                       child: Container(
            //                         padding: const EdgeInsets
            //                             .symmetric(
            //                             horizontal: 8,
            //                             vertical: 2),
            //                         decoration: BoxDecoration(
            //                           color: primaryColor,
            //                           borderRadius:
            //                           BorderRadius.circular(
            //                               5),
            //                         ),
            //                         child: Text(
            //                           "Order Now",
            //                           style: Text_inside_button,
            //                         ),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ]),
            //       SizedBox(
            //         height: h / 80,
            //       ),
            //     ],
            //   );
            // },),
            SizedBox(
              height: h / 80,
            ),
          ],
        ),
      ),
    );
  }
}
