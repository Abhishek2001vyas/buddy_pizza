import 'package:buddy_pizza/view/screen/dashboard/home/your_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/hotdeals_api.dart';
import '../../../api/subcategorieslist_api.dart';
import '../../../controller.dart';
import '../../../theme/color.dart';
import '../../../theme/text2.dart';
import '../../../utils/constant.dart';

class OrderDetails1 extends StatefulWidget {
  final index;

  const OrderDetails1({super.key, this.index});

  @override
  State<OrderDetails1> createState() => _OrderDetails1State();
}

class _OrderDetails1State extends State<OrderDetails1> {
  PizzaController controller = Get.put(PizzaController());
  var selectedOption;

  var selectedOption2;
  var selectedOption1;
  bool checkedValue = true;
  bool _isChanged = true;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: h / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                      "$user_image_url${hot.elementAt(0)[widget.index]["product_image"]}",
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: w,
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: h / 30,
                        ),
                        Text(
                          hot.elementAt(0)[widget.index]["product_name"] ?? "",
                          style: TextBold,
                        ),
                        Text(
                          hot.elementAt(0)[widget.index]["description"] ?? "",
                          style: TextStyle(
                              //letterSpacing: 2,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,

                              //  fontFamily: "Amazon_med",
                              fontSize: 14),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: w / 2.3,
                  top: 0,
                  child: Container(
                      width: w,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: h / 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose the Size", style: A_style_medium),

                  ListView.builder(
                    itemCount:
                        hot.elementAt(0)[widget.index]["size_name"].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: Radio(
                              activeColor: primaryColor,
                              value: hot.elementAt(0)[widget.index]["size_name"]
                                  [index]["size"],
                              groupValue: selectedOption ??
                                  hot.elementAt(0)[widget.index]["size_name"][0]
                                      ["size"],
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                  print("Button value: $value");
                                  print(
                                      "selectedOption value: $selectedOption");
                                });
                              },
                            ),
                          ),
                          SizedBox(
                              width: w / 1.7,
                              child: Text(hot.elementAt(0)[widget.index]
                                      ["size_name"][index]["size"] ??
                                  "")),
                          const Spacer(),
                          Text("CAD " +
                                  hot.elementAt(0)[widget.index]["size_name"]
                                      [index]["price"] ??
                              ""),
                        ],
                      );
                    },
                  ),
                  Text("Choose the Crust", style: A_style_medium),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: curstlist.elementAt(0).length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: Radio(
                              activeColor: primaryColor,
                              value: curstlist.elementAt(0)[index]["name"],
                              groupValue: selectedOption2 ??
                                  curstlist.elementAt(0)[0]["name"],
                              onChanged: (value) {
                                setState(() {
                                  selectedOption2 = value;
                                  print("Button value: $value");
                                });
                              },
                            ),
                          ),
                          SizedBox(
                              width: w / 1.7,
                              child: Text(
                                  curstlist.elementAt(0)[index]["name"] ?? "")),
                          const Spacer(),
                          Text(
                              "CAD " + curstlist.elementAt(0)[index]["price"] ??
                                  ""),
                        ],
                      );
                    },
                  ),
                  Text("Add Dips", style: A_style_medium),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: diplist.elementAt(0).length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: Radio(
                              activeColor: primaryColor,
                              value: diplist.elementAt(0)[index]["name"],
                              groupValue: selectedOption1 ??
                                  diplist.elementAt(0)[0]["name"],
                              onChanged: (value) {
                                setState(() {
                                  selectedOption1 = value;
                                  print("Button value: $value");
                                });
                              },
                            ),
                          ),
                          SizedBox(
                              width: w / 1.7,
                              child: Text(
                                  diplist.elementAt(0)[index]["name"] ?? "")),
                          const Spacer(),
                          Text("CAD " + diplist.elementAt(0)[index]["price"] ??
                              ""),
                        ],
                      );
                    },
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       height: 35,
                  //       width: 35,
                  //       child: Checkbox(
                  //         activeColor: primaryColor,
                  //         value: checkedValue,
                  //         onChanged: (newValue) {
                  //           setState(() {
                  //             checkedValue = newValue!;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //     const Text("Add Extra cheese to crust"),
                  //     const Spacer(),
                  //     const Text("+CAD 60"),
                  //   ],
                  // ),
                  // Theme(
                  //   data: Theme.of(context)
                  //       .copyWith(dividerColor: Colors.transparent),
                  //   child: ExpansionTile(
                  //       iconColor: Colors.black,
                  //       title: Text('Add a Dip', style: A_style_medium),
                  //       children: [
                  //         GetBuilder<PizzaController>(
                  //             builder: (PizzaController controller) {
                  //           return Container(
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                       color: Colors.grey.shade300,
                  //                       blurRadius: 3)
                  //                 ]),
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 InkWell(
                  //                   onTap: () {
                  //                     controller.decrement();
                  //                   },
                  //                   child: Container(
                  //                       width: 40,
                  //                       decoration: const BoxDecoration(
                  //                         color: Colors.black,
                  //                         borderRadius: BorderRadius.only(
                  //                             topLeft: Radius.circular(20),
                  //                             bottomLeft: Radius.circular(20)),
                  //                       ),
                  //                       child: const Text(
                  //                         "-",
                  //                         style: TextStyle(
                  //                             fontSize: 25,
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.bold),
                  //                         textAlign: TextAlign.center,
                  //                       )),
                  //                 ),
                  //                 Text(
                  //                   "QTy:${controller.counter}",
                  //                   style: const TextStyle(color: Colors.black),
                  //                 ),
                  //                 InkWell(
                  //                   onTap: () {
                  //                     controller.increment();
                  //                   },
                  //                   child: Container(
                  //                       width: 40,
                  //                       decoration: const BoxDecoration(
                  //                         color: Colors.black,
                  //                         borderRadius: BorderRadius.only(
                  //                             topRight: Radius.circular(20),
                  //                             bottomRight: Radius.circular(20)),
                  //                       ),
                  //                       child: const Text(
                  //                         "+",
                  //                         style: TextStyle(
                  //                             fontSize: 25,
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.bold),
                  //                         textAlign: TextAlign.center,
                  //                       )),
                  //                 )
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //         SizedBox(
                  //           height: h / 90,
                  //         ),
                  //       ]),
                  // ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                        iconColor: Colors.black,
                        title: Text('Add a Cheese', style: A_style_medium),
                        children: [
                          GetBuilder<PizzaController>(
                              builder: (PizzaController controller) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 3)
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.decrement();
                                    },
                                    child: Container(
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                        ),
                                        child: const Text(
                                          "-",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                  Text(
                                    "QTy:${controller.counter}",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.increment();
                                    },
                                    child: Container(
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                        ),
                                        child: const Text(
                                          "+",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),
                                  )
                                ],
                              ),
                            );
                          }),
                        ]),
                  ),
                  SizedBox(
                    height: h / 90,
                  ),
                  InkWell(
                    onTap: () {
                     // Get.to(() => const YourOrder());
                    },
                    child: Container(
                      width: w,
                      padding:
                          EdgeInsets.symmetric(horizontal: w / 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Add To Order",
                        style: TextBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Container(
//   padding: EdgeInsets.symmetric(
//       horizontal: w / 10, vertical: 8),
//   decoration: BoxDecoration(
//     color: Colors.black,
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: Text(
//     "Customize",
//     style: TextBold,
//   ),
// ),
