import 'package:buddy_pizza/view/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../api/orderplaceed_api.dart';
import '../../../../theme/color.dart';
import '../../../../theme/text2.dart';

class TrackOrderDetails extends StatefulWidget {
  final indexx;

  const TrackOrderDetails({super.key, this.indexx});

  @override
  State<TrackOrderDetails> createState() => _TrackOrderDetailsState();
}

class _TrackOrderDetailsState extends State<TrackOrderDetails> {
  List<StepData> steps = [
    StepData(
      title: 'Order Placed',
    ),
    StepData(
      title: 'Order Accepted',
    ),
    StepData(
      title: 'Order Packed',
    ),
    StepData(
      title: 'Order Out Of Delivery',
    ),
    StepData(
      title: 'Order Delivered',
    ),
    StepData(
      title: 'Order Cancelled', // New step for order cancellation
    ),
  ];
  final Orderplaced_api placedlist = Get.put(Orderplaced_api());

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Order ID: ${placedlist.placeorderlistt[0][widget.indexx]["_id"]}",
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: placedlist
                          .placeorderlistt[0][widget.indexx]["orderId"]
                              ["cartId"]["products"]
                          .length,
                      itemBuilder: (context, index1) {
                        return Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "$user_image_url${placedlist.placeorderlistt[0][widget.indexx]["orderId"]["cartId"]["products"][index1]["image"]}"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    placedlist.placeorderlistt[0][widget.indexx]
                                                    ["orderId"]["cartId"]
                                                ["products"][index1]
                                            ["product_name"] ??
                                        "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          'CAD ${placedlist.placeorderlistt[0][widget.indexx]["orderId"]["cartId"]["products"][index1]["cart_price"].toString()}'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "Qty: ${placedlist.placeorderlistt[0][widget.indexx]["orderId"]["cartId"]["products"][index1]["order_quantity"] ?? ""}")
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: h / 100,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h / 80,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w / 8,
                      height: h / 13,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            width: w / 25,
                            height: h / 30,
                            decoration: BoxDecoration(
                              color: index <= selectedIndex
                                  ? primaryColor
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: index <= selectedIndex
                                ? const Center(
                                    child: Text(
                                    "✓",
                                    style: TextStyle(color: Colors.white),
                                  ))
                                : null,
                          ),
                          if (index < steps.length - 1)
                            Expanded(
                              child: Container(
                                width: 2,
                                color: index <= selectedIndex - 1
                                    ? primaryColor
                                    : Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            selectedIndex == 5
                                ? Text(
                                    steps[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: w / 25,
                                      color: index == selectedIndex
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  )
                                : Text(
                                    steps[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: w / 25,
                                    ),
                                  ),
                            SizedBox(height: h / 90),
                            index == 1
                                ? Text(
                                    "hhh",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: w / 30,
                                    ),
                                  )
                                : index == 2
                                    ? Text(
                                        "20/01/24",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: w / 30,
                                        ),
                                      )
                                    : index == 3
                                        ? Text("20/01/24",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: w / 30,
                                            ))
                                        : const Text(""),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        selectedIndex == 3
                            ? index == 3
                                ? InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: h / 30,
                                      width: w / 2.9,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple.shade50,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Center(
                                          child: Text(
                                        "Track Your Order",
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                    ),
                                  )
                                : const Text("")
                            : const Text(""),
                      ],
                    ),
                  ],
                );
              },
            ),
            placedlist.placeorderlistt[0][widget.indexx]["status_mode"] == 0
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 3,
                          )
                        ],
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        SizedBox(
                          width: w / 1.3,
                          child: Text(
                            placedlist.placeorderlistt[0][widget.indexx]
                                ["address"],
                            style: A_style_foot,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 3,
                          )
                        ],
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_sharp,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        SizedBox(
                          width: w / 1.3,
                          child: Text(
                            "Delivery mode : PickUp",
                            // style: A_style_foot,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: h / 90,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                    )
                  ],
                  border: Border.all(color: Colors.grey.shade200, width: 1)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub Total",
                        style: A_style_order,
                      ),
                      Text(
                        "CAD ${placedlist.placeorderlistt[0][widget.indexx]["sub_total"]}",
                        style: A_style_order,
                      )
                    ],
                  ),
                  SizedBox(
                    height: h / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: A_style_order,
                      ),
                      Text(
                        "- CAD ${placedlist.placeorderlistt[0][widget.indexx]["coupon"] ?? ""}",
                        style: TextStyle(
                            //letterSpacing: 1.5,
                            //color: Colors.white,

                            color: Colors.red,
                            overflow: TextOverflow.ellipsis,
                            //  fontFamily: "Amazon_med",
                            fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Takes and Charges",
                        style: A_style_order,
                      ),
                      Text(
                        "CAD ${placedlist.placeorderlistt[0][widget.indexx]["taxes_and_charges"]}",
                        style: A_style_order,
                      )
                    ],
                  ),
                  SizedBox(
                    height: h / 100,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: Text_Lit_Bold,
                      ),
                      Text(
                        "CAD ${placedlist.placeorderlistt[0][widget.indexx]["total"]}",
                        style: TextStyle(
                            //letterSpacing: 2.5,
                            //color: Colors.white,
                            color: Colors.green,
                            //  fontFamily: "Amazon_bold",
                            fontSize: 18),
                      )
                    ],
                  ),

                  SizedBox(
                    height: h / 20,
                  ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rev = rating;
                        });
                        print(rating);
                      },
                    ),
                  ),
                  SizedBox(
                    height: h / 40,
                  ),
                  TextFormField(
                    controller: Review,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: Colors.black))),),
                  SizedBox(
                    height: h / 100,
                  ),
                  Container(
                      width: w,height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                          onPressed: (){
                            placedlist.revielist(rev,Review.text,placedlist.placeorderlistt[0][widget.indexx]["_id"]);

                          }, child: Text("Review",style: TextStyle(color: Colors.white),)))


                ],
              ),
            ),
          ],
        ),
      ),
      /*   bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3)]),
        child: CustomButton(
          title: 'Track Your Order',
          onTap: () {
            Get.back();
          },
        ),
      ),*/
    );
  }
  var rev = 4.0;
  TextEditingController Review =TextEditingController();
}

class StepData {
  final String title;

  StepData({
    required this.title,
  });
}
