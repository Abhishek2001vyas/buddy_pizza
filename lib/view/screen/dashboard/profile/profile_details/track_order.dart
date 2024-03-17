import 'package:buddy_pizza/view/screen/dashboard/profile/profile_details/track_order_details.dart';
import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../api/orderplaceed_api.dart';
import '../../../../utils/constant.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({
    super.key,
  });

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final Orderplaced_api placedlist = Get.put(Orderplaced_api());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            "Track Order",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
              future: placedlist.placeorderlist(),
              builder: (context, snapshot) =>
              snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  :
              snapshot.hasError ?
              Center(
                child: Image.asset(
                  "assets/images/output-onlinegiftools.gif",
                  height: h / 2, width: w / 2,),
              )
                  :
              snapshot.hasData?
              ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data[0].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => TrackOrderDetails(
                                    indexx: index,
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 3)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: placedlist
                                          .placeorderlistt[0][index]["orderId"]
                                              ["cartId"]["products"]
                                          .length,
                                      itemBuilder: (context, index1) {
                                        return
                                          placedlist
                                              .placeorderlistt[0][index]["orderId"]
                                          ["cartId"]["products"].isEmpty?
                                              SizedBox():

                                          Container(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "$user_image_url${placedlist.placeorderlistt[0][index]["orderId"]["cartId"]["products"][index1]["image"]}"),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    placedlist.placeorderlistt[0]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "orderId"]
                                                                    [
                                                                    "cartId"]
                                                                [
                                                                "products"][index1]
                                                            ["product_name"] ??
                                                        "",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'CAD ${placedlist.placeorderlistt[0][index]["orderId"]["cartId"]["products"][index1]["cart_price"].toString()}'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                      "Qty: ${placedlist.placeorderlistt[0][index]["orderId"]["cartId"]["products"][index1]["order_quantity"] ?? ""}")
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: h / 100,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Delivery mode : "),
                                            placedlist.placeorderlistt[0][index]
                                                        ["status_mode"] ==
                                                    0
                                                ? Text("Delivery")
                                                : Text("Pickup")
                                          ],
                                        ),
                                        Text(
                                          "Track Order",
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: h / 100,
                                    ),
                                    Row(
                                      children: [
                                        Text("total : "),
                                        Text("CAD " +
                                            placedlist.placeorderlistt[0][index]
                                                    ["total"]
                                                .toString())
                                      ],
                                    ),
                                    SizedBox(
                                      height: h / 100,
                                    ),
],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
              :
              Center(
                child: Image.asset(
                  "assets/images/output-onlinegiftools.gif",
                  height: h / 2, width: w / 2,),
              )
              ,
            )));
  }
  var rev = 4.0;
  TextEditingController Review =TextEditingController();
}
