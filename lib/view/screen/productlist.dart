import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/subcategorieslist_api.dart';
import '../theme/color.dart';
import '../theme/text2.dart';
import '../utils/constant.dart';

class Product_list extends StatefulWidget {
  const Product_list({super.key, this.subcategories_id});

  final subcategories_id;

  @override
  State<Product_list> createState() => _Product_listState();
}

class _Product_listState extends State<Product_list> {
  final subcatergoriesapi = Get.put(Subcategories_api());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                future: subcatergoriesapi.product(widget.subcategories_id),
                builder: (context, snapshot) {
                  return productlist.isEmpty
                      ? Center(
                          child: Image.asset(
                            "assets/images/output-onlinegiftools.gif",
                            height: h / 2,
                            width: w / 2,
                          ),
                        )
                      :
                      // productlist.elementAt(0)[0]["size_name"].isEmpty ?
                      ListView.builder(
                          itemCount: productlist.elementAt(0).length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // Get.to(() => const OrderDetails());
                              },
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      width: w / 1.043,
                                      height: h / 3.5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "$user_image_url${productlist.elementAt(0)[0]["product_image"]}",
                                            ),
                                            fit: BoxFit.cover,
                                          )),
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
                                              productlist.elementAt(0)[index]
                                                  ["product_name"],
                                              style: TextBold,
                                            ),
                                            Text(
                                              productlist.elementAt(0)[index]
                                                      ["description"] ??
                                                  "",
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
                                                //   "CAD 49",
                                                //   style: TextBold,
                                                // ),
                                                Container(
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
                              ),
                            );
                          });
                  //:
                  //   ListView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: productlist.elementAt(0).length,
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //     return
                  //       Column(
                  //         children: [
                  //           ListTile(
                  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
                  //               side: BorderSide(color: Colors.black,width: 1)),
                  //             onTap: (){
                  //               Get.to(() =>  OrderDetails(index: index,));
                  //              // subcatergoriesapi.size(productlist.elementAt(0)[index]["_id"]);
                  //                               },
                  //             title: Text( productlist.elementAt(0)[index]["product_name"]??""),
                  //             trailing: Icon(Icons.arrow_forward_ios),),
                  //           SizedBox(height: 10,)
                  //         ],
                  //       );
                  //   },);
                  // :SizedBox()
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
