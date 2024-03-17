import 'package:buddy_pizza/view/api/homebanner_api.dart';
import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/address.dart';
import '../../../api/orderplaceed_api.dart';
import '../../../base/custom_button.dart';
import '../../../theme/text2.dart';
import '../../../utils/utils.dart';
import '../coupon_screen.dart';
import 'add_address.dart';
var applipoints;
class YourOrder extends StatefulWidget {
  final cartId;
  const YourOrder({super.key, this.cartId});

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
  bool _isSelected = false;
  TextEditingController Coupen = TextEditingController();
  TextEditingController ponits = TextEditingController();
  dynamic orderList = [0];
  List order = [
    "Delivery",
    "PicUp",
  ];
  String selectedOption ="male";

  int selectedOption2 = 1;
  final getaddress = Get.put(Address_api());
  final placedorder = Get.put(Orderplaced_api());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h / 16,
              child: ListView.builder(
                  itemCount: order.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          orderList.clear();
                          orderList.add(index);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: orderList.contains(index)
                              ? Colors.red.shade50
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 3,
                            )
                          ],
                          border: orderList.contains(index)
                              ? Border.all(color: Colors.red.shade100)
                              : Border.all(color: Colors.grey.shade50),
                        ),
                        child: Text(
                          order[index].toString(),
                          style: orderList.contains(index)
                              ? const TextStyle(
                                  fontSize: 17,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700)
                              : const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: h / 100,
            ),
            orderList.contains(0).toString() == "true"
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child: Column(
                          children: [
                            orderlistt.elementAt(0).isEmpty
                                ? SizedBox():
                            orderlistt.elementAt(0)["products"].length<=2?
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Order List",
                                          style: A_style_medium),
                                      ListView.builder(
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        itemCount: orderlistt
                                            .elementAt(0)["products"]
                                            .length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (context, index) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                  width: w / 2,
                                                  child: Text(orderlistt
                                                      .elementAt(
                                                      0)["products"][index]
                                                  [
                                                  "product_name"] ??
                                                      "")),
                                              SizedBox(
                                                  width: w / 8,
                                                  child: Text(orderlistt
                                                      .elementAt(0)[
                                                  "products"]
                                                  [index][
                                                  "order_quantity"]
                                                      .toString() ??
                                                      "")),
                                              Text("CAD " +
                                                  orderlistt
                                                      .elementAt(0)[
                                                  "products"]
                                                  [index][
                                                  "cart_price"]
                                                      .toString() ??
                                                  ""),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ) ,
                                )
                                : SizedBox(
                                    width: w / 1,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(childrenPadding: EdgeInsets.only(left: 15,top: 8,bottom: 8,right: 8),
                                        trailing: Text("More +"),
                                        title: Text("Order List",
                                            style: A_style_medium),
                                        children: [
                                          orderlistt
                                                  .elementAt(0)["products"]
                                                  .isEmpty
                                              ? SizedBox()
                                              : ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: orderlistt
                                                      .elementAt(0)["products"]
                                                      .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Row(
                                                      children: [
                                                        SizedBox(
                                                            width: w / 2,
                                                            child: Text(orderlistt
                                                                        .elementAt(
                                                                            0)["products"][index]
                                                                    [
                                                                    "product_name"] ??
                                                                "")),
                                                        SizedBox(
                                                            width: w / 8,
                                                            child: Text(orderlistt
                                                                    .elementAt(0)[
                                                                        "products"]
                                                                        [index][
                                                                        "order_quantity"]
                                                                    .toString() ??
                                                                "")),
                                                        Text("CAD " +
                                                                orderlistt
                                                                    .elementAt(0)[
                                                                        "products"]
                                                                        [index][
                                                                        "cart_price"]
                                                                    .toString() ??
                                                            ""),
                                                      ],
                                                    );
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: h / 80,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h / 50,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child:
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                leading: Icon(Icons.loyalty),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color: Colors.green.shade700,
                                ),
                                childrenPadding: EdgeInsets.all(8),
                                title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${loyaltypoint[0]} Loyalty Points", style: A_style_medium),


                                  ],
                                ),

                                children: [

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          width: w / 1.5,
                                          height: h / 20,
                                          child: TextFormField(
                                            controller: ponits,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    borderSide: BorderSide(
                                                        color: Colors.black))),
                                          )),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            applipoints=ponits.text.toString();
                                          });
                                          placedorder.appltpoint(ponits.text.toString());
                                        },
                                        child: Container(
                                          height: h / 20,
                                          width: w / 5,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                                "Apply",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            applyointlistt.isEmpty?
                            SizedBox():
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child:
                              ListTile(
                                leading: SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Radio(
                                    activeColor: primaryColor,
                                    value: "male",
                                    groupValue: selectedOption,
                                    toggleable: true,
                                    onChanged: (value) {
                                      print("vvv${value.toString()}");
                                      setState(() {
                                        selectedOption = value ?? (selectedOption == "male" ? "" : "male");

                                      });
                                      print("hhhh");
                                      print("Button value: $value");
                                    },
                                  ),
                                ),
                                title:  Text("${applipoints} Loyalty Points Redeem",
                                    style: A_style_mid_black),
                              )
                              // Row(
                              //   children: [
                              //
                              //     SizedBox(
                              //       width: w / 50,
                              //     ),
                              //
                              //   ],
                              // ),
                            ),
                          ],
                        )

                      ),
                      SizedBox(
                        height: h / 50,
                      ),
                      Obx(() {
                        print("abhhh${ placedorder.coupenred}");
                        return
                      placedorder.coupenred.isNotEmpty?
                      Container(
                        width: w / 1,
                        height: h/9,
                        decoration: BoxDecoration(
color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child:Row(
                          children: [
                            Container(
                              width: w/5,decoration: BoxDecoration(
                              color: Colors.green
                            ),
                              child: Column(
                                children: [
                                  Container(
                                    height: h/20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.check,color: Colors.green),
                                  ),
                                  Text("offer",style: TextStyle(color: Colors.white),),
                                  Text("Applied",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                            SizedBox(width: w/30,),
                            SizedBox(width: w/1.7,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("You Saved ${placedorder.coupenred[0]['discount_price']} %",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),
                                    Text(" ${placedorder.coupenred[0]['coupon_code']} Applied",style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              ),
                            ),
                            IconButton(onPressed: (){
                              placedorder.deletecoupen(placedorder.coupenred[0]['_id']);
                            }, icon: Icon(Icons.delete,color: Colors.white,))
                          ],
                        )
                      )

                          :

                      Container(
                        width: w / 1,
                        height: h/13,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child:

                        ListTile(
                          onTap: (){
                              Get.to(CouponScreen());
                            }

                            ,
                              title: Text("Apply Coupon", style: A_style_medium),
                           trailing:  Icon(
                             Icons.keyboard_arrow_right_outlined,
                             color: Colors.green.shade700,
                           ),
                              leading: Icon(Icons.local_offer_outlined),
                            )

                        // Theme(
                        //   data: Theme.of(context)
                        //       .copyWith(dividerColor: Colors.transparent),
                        //   child: ExpansionTile(
                        //     leading: Icon(Icons.local_offer_outlined),
                        //     trailing: Icon(
                        //       Icons.keyboard_arrow_right_outlined,
                        //       color: Colors.green.shade700,
                        //     ),
                        //     childrenPadding: EdgeInsets.all(8),
                        //     title: Text("Apply Coupon", style: A_style_medium),
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           Container(
                        //               width: w / 1.5,
                        //               height: h / 20,
                        //               child: TextFormField(
                        //                 controller: Coupen,
                        //                 decoration: InputDecoration(
                        //                     border: OutlineInputBorder(
                        //                         borderRadius:
                        //                             BorderRadius.circular(5),
                        //                         borderSide: BorderSide(
                        //                             color: Colors.black))),
                        //               )),
                        //           Container(
                        //             height: h / 20,
                        //             width: w / 5,
                        //             decoration: BoxDecoration(
                        //                 color: Colors.green,
                        //                 borderRadius: BorderRadius.circular(5)),
                        //             child: Center(
                        //                 child: Text(
                        //               "Apply",
                        //               style: TextStyle(color: Colors.white),
                        //             )),
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                      );}),
                      SizedBox(
                        height: h / 50,
                      ),
                      Container(
                        width: w / 1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            leading: Icon(Icons.location_on_sharp),
                            trailing:
                            // Addresslist.isNotEmpty?
                            // SizedBox(
                            //   height: 35,
                            //   width: 35,
                            //   child: Radio(
                            //     activeColor: primaryColor,
                            //     value: 1,
                            //     groupValue: selectedOption2,
                            //     // toggleable: true,
                            //     onChanged: (value) {
                            //       print(
                            //           "vvv${value.runtimeType.toString()}");
                            //       setState(() {
                            //         selectedOption2 =
                            //         value as int;
                            //       });
                            //       print("hhhh");
                            //       print("Button value: $value");
                            //     },
                            //   ),
                            // )
                            //     :
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.green.shade700,
                            ),
                            childrenPadding: EdgeInsets.all(8),
                            title:
                            FutureBuilder(
                              future: getaddress.Addresslistapi(),
                              builder: (context, snapshot) {
                                return Addresslist.isNotEmpty
                                    ? Row(
                                  children: [

                                    SizedBox(
                                      width: w / 1.7,
                                      child: Text(
                                          maxLines: 3,
                                          "${Addresslist[0]["house_no"]}, ${Addresslist[0]["floor_no"]},${Addresslist[0]["building_name"]},${Addresslist[0]["how_to_reach"]},${Addresslist[0]["contact_no"]}"),
                                    )
                                  ],
                                )
                                    :    Text("Address", style: A_style_medium);
                              },
                            ),


                            children: [

                              // SizedBox(height: h / 100),
                              // Addresslist.isNotEmpty
                              //     ? Text("----------------- OR ---------------")
                              //     : Text(""),
                              // Addresslist.isNotEmpty
                              //     ? SizedBox(height: h / 100)
                              //     : SizedBox(),
                              GestureDetector(
                                onTap: () {
                                  Get.to(AddAddress(
                                    goto: 1,
                                  ));
                                },
                                child: Container(
                                  height: h / 20,
                                  width: w / 1,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    "+ ADD ADDRESS",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h / 80,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 3,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.shade200, width: 1)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: LightText,
                                ),
                                Text(
                                  "+CAD ${orderlistt
                                      .elementAt(0)[
                                  "grand_total"]
                                  }",
                                  style: LightText,
                                )
                              ],
                            ),
                            SizedBox(
                              height: h / 100,
                            ),
                            Obx(() =>
                            placedorder.coupenred.isNotEmpty?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Coupen appiled",
                                  style: LightText,
                                ),
                                Text(
                                  "- CAD ${orderlistt
                                      .elementAt(0)[
                                  "grand_total"]* (placedorder.coupenred[0]['discount_price']/100)
                                  }",
                                  style: LightText,
                                )
                              ],
                            ):SizedBox()),
                            Obx(() =>
                            placedorder.coupenred.isNotEmpty? SizedBox(
                              height: h / 100,
                            ):SizedBox()),

                            applyointlistt.isNotEmpty&& selectedOption=="male" ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "loyalty point appiled",
                                  style: LightText,
                                ),
                                Text(
                                  "- CAD ${applyointlistt[0].toStringAsFixed(4)
                                  }",
                                  style: LightText,
                                )
                              ],
                            ):SizedBox(),
                             applyointlistt.isNotEmpty? SizedBox(
                              height: h / 100,
                            ):SizedBox(),
                            Obx(() =>    Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Charges",
                                  style: LightText,
                                ),
                                Text(
                                  " CAD ${getaddress.deliverychager}",
                                  style: LightText,
                                )
                              ],
                            ))
                         ,
                            SizedBox(
                              height: h / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Taxes and Charges %",
                                  style: LightText,
                                ),
                                Text(
                                  " ${chargelistt[0][0]["tax"]}",
                                  style: LightText,
                                )
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: A_style_medium,
                                ),
                               Obx(() =>
                                placedorder.coupenred.isNotEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?
                                Text  (
                                  "CAD ${(int.parse(getaddress.deliverychager.value.toString())+orderlistt .elementAt(0)[ "grand_total"]+
                                      (orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-
                                      double.parse(applyointlistt[0].toStringAsFixed(4))-
                                      (orderlistt.elementAt(0)[
                                  "grand_total"]* (placedorder.coupenred[0]['discount_price']/100))}",
                                  style: TextStyle(
                                    //letterSpacing: 2.5,
                                    //color: Colors.white,
                                      color: Colors.green.shade700,
                                      fontSize: 14),
                                  maxLines: 2,
                                )
                                    :
                                placedorder.coupenred.isEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?
                                Obx(() =>

                                    Text(
                                  "CAD ${
                                      ((int.parse(getaddress.deliverychager.value.toString())+
                                      orderlistt .elementAt(0)[ "grand_total"]+
                                          (orderlistt .elementAt(0)[ "grand_total"]*
                                          (int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-double.parse(applyointlistt[0].toStringAsFixed(4))
                                  )}",
                                  style: TextStyle(
                                      //letterSpacing: 2.5,
                                      //color: Colors.white,
                                      color: Colors.green.shade700,
                                      fontSize: 14),
                                  maxLines: 2,
                                )):
                                    placedorder.coupenred.isNotEmpty && applyointlistt.isEmpty &&selectedOption==""?
                                    Obx(() => Text(
                                      "CAD ${((int.parse(getaddress.deliverychager.value.toString())+
                                          orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))
                                          -
                                          (orderlistt.elementAt(0)[
                                          "grand_total"]* (placedorder.coupenred[0]['discount_price']/100))
                                      )}",
                                      style: TextStyle(
                                        //letterSpacing: 2.5,
                                        //color: Colors.white,
                                          color: Colors.green.shade700,
                                          fontSize: 14),
                                      maxLines: 2,
                                    )):
                                    Text(
                                      "CAD ${((int.parse(getaddress.deliverychager.value.toString())+
                                          orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))

                                      )}",
                                      style: TextStyle(
                                        //letterSpacing: 2.5,
                                        //color: Colors.white,
                                          color: Colors.green.shade700,
                                          fontSize: 14),
                                      maxLines: 2,
                                    )
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            orderList.contains(1).toString() == "true"
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child: Column(
                          children: [
                            orderlistt.elementAt(0).isEmpty
                                ? SizedBox():
                            orderlistt.elementAt(0)["products"].length<=2?
                            Container(
                              padding: EdgeInsets.all(8),
                              child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order List",
                                      style: A_style_medium),
                                  ListView.builder(
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    itemCount: orderlistt
                                        .elementAt(0)["products"]
                                        .length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (context, index) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                              width: w / 2,
                                              child: Text(orderlistt
                                                  .elementAt(
                                                  0)["products"][index]
                                              [
                                              "product_name"] ??
                                                  "")),
                                          SizedBox(
                                              width: w / 8,
                                              child: Text(orderlistt
                                                  .elementAt(0)[
                                              "products"]
                                              [index][
                                              "order_quantity"]
                                                  .toString() ??
                                                  "")),
                                          Text("CAD " +
                                              orderlistt
                                                  .elementAt(0)[
                                              "products"]
                                              [index][
                                              "cart_price"]
                                                  .toString() ??
                                              ""),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ) ,
                            )
                                : SizedBox(
                              width: w / 1,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent),
                                child: ExpansionTile(childrenPadding: EdgeInsets.only(left: 15,top: 8,bottom: 8,right: 8),
                                  trailing: Text("More +"),
                                  title: Text("Order List",
                                      style: A_style_medium),
                                  children: [
                                    orderlistt
                                        .elementAt(0)["products"]
                                        .isEmpty
                                        ? SizedBox()
                                        : ListView.builder(
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: orderlistt
                                          .elementAt(0)["products"]
                                          .length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (context, index) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                                width: w / 2,
                                                child: Text(orderlistt
                                                    .elementAt(
                                                    0)["products"][index]
                                                [
                                                "product_name"] ??
                                                    "")),
                                            SizedBox(
                                                width: w / 8,
                                                child: Text(orderlistt
                                                    .elementAt(0)[
                                                "products"]
                                                [index][
                                                "order_quantity"]
                                                    .toString() ??
                                                    "")),
                                            Text("CAD " +
                                                orderlistt
                                                    .elementAt(0)[
                                                "products"]
                                                [index][
                                                "cart_price"]
                                                    .toString() ??
                                                ""),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h / 80,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h / 50,
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(Icons.loyalty),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    color: Colors.green.shade700,
                                  ),
                                  childrenPadding: EdgeInsets.all(8),
                                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${loyaltypoint[0]} Loyalty Points", style: A_style_medium),


                                    ],
                                  ),

                                  children: [

                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            width: w / 1.5,
                                            height: h / 20,
                                            child: TextFormField(
                                              controller: ponits,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      borderSide: BorderSide(
                                                          color: Colors.black))),
                                            )),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              applipoints=ponits.text.toString();
                                            });
                                            placedorder.appltpoint(ponits.text.toString());
                                          },
                                          child: Container(
                                            height: h / 20,
                                            width: w / 5,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(5)),
                                            child: Center(
                                                child: Text(
                                                  "Apply",
                                                  style: TextStyle(color: Colors.white),
                                                )),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              applyointlistt.isEmpty?
                              SizedBox():
                              Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child:
                                  ListTile(
                                    leading: SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Radio(
                                        activeColor: primaryColor,
                                        value: "male",
                                        groupValue: selectedOption,
                                        toggleable: true,
                                        onChanged: (value) {
                                          print("vvv${value.toString()}");
                                          setState(() {
                                            selectedOption = value ?? (selectedOption == "male" ? "" : "male");
                                          });
                                          print("hhhh");
                                          print("Button value: $value");
                                        },
                                      ),
                                    ),
                                    title:  Text("${applipoints} Loyalty Points Redeem",
                                        style: A_style_mid_black),
                                  )
                                // Row(
                                //   children: [
                                //
                                //     SizedBox(
                                //       width: w / 50,
                                //     ),
                                //
                                //   ],
                                // ),
                              ),
                            ],
                          )

                      ),
                      SizedBox(
                        height: h / 50,
                      ),
                      Obx(() =>
                      placedorder.coupenred.isNotEmpty?
                      Container(
                          width: w / 1,
                          height: h/9,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child:Row(
                            children: [
                              Container(
                                width: w/5,decoration: BoxDecoration(
                                  color: Colors.green
                              ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: h/20,
                                      decoration: BoxDecoration(
                                          color: Colors.white,shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.check,color: Colors.green),
                                    ),
                                    Text("offer",style: TextStyle(color: Colors.white),),
                                    Text("Applied",style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              ),
                              SizedBox(width: w/30,),
                              SizedBox(width: w/1.7,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("You Saved ${placedorder.coupenred[0]['discount_price']} %",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white)),
                                      Text(" ${placedorder.coupenred[0]['coupon_code']} Applied",style: TextStyle(color: Colors.white),)
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){
                                placedorder.deletecoupen(placedorder.coupenred[0]['_id']);
                              }, icon: Icon(Icons.delete,color: Colors.white,))
                            ],
                          )
                      )

                          :

                      Container(
                          width: w / 1,
                          height: h/13,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300, blurRadius: 3)
                              ]),
                          child:

                          ListTile(
                            onTap: (){
                              Get.to(CouponScreen());
                            }

                            ,
                            title: Text("Apply Coupon", style: A_style_medium),
                            trailing:  Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.green.shade700,
                            ),
                            leading: Icon(Icons.local_offer_outlined),
                          )

                        // Theme(
                        //   data: Theme.of(context)
                        //       .copyWith(dividerColor: Colors.transparent),
                        //   child: ExpansionTile(
                        //     leading: Icon(Icons.local_offer_outlined),
                        //     trailing: Icon(
                        //       Icons.keyboard_arrow_right_outlined,
                        //       color: Colors.green.shade700,
                        //     ),
                        //     childrenPadding: EdgeInsets.all(8),
                        //     title: Text("Apply Coupon", style: A_style_medium),
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           Container(
                        //               width: w / 1.5,
                        //               height: h / 20,
                        //               child: TextFormField(
                        //                 controller: Coupen,
                        //                 decoration: InputDecoration(
                        //                     border: OutlineInputBorder(
                        //                         borderRadius:
                        //                             BorderRadius.circular(5),
                        //                         borderSide: BorderSide(
                        //                             color: Colors.black))),
                        //               )),
                        //           Container(
                        //             height: h / 20,
                        //             width: w / 5,
                        //             decoration: BoxDecoration(
                        //                 color: Colors.green,
                        //                 borderRadius: BorderRadius.circular(5)),
                        //             child: Center(
                        //                 child: Text(
                        //               "Apply",
                        //               style: TextStyle(color: Colors.white),
                        //             )),
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                      )),

                      SizedBox(
                        height: h / 80,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 3,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.shade200, width: 1)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: LightText,
                                ),
                                Text(
                                  "+CAD ${orderlistt
                                      .elementAt(0)["grand_total"]
                                  }",
                                  style: LightText,
                                )
                              ],
                            ),
                            SizedBox(
                              height: h / 100,
                            ),
                            Obx(() =>
                            placedorder.coupenred.isNotEmpty?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Coupen appiled",
                                  style: LightText,
                                ),
                                Text(
                                  "- CAD ${orderlistt
                                      .elementAt(0)[
                                  "grand_total"]* (placedorder.coupenred[0]['discount_price']/100)
                                  }",
                                  style: LightText,
                                )
                              ],
                            ):SizedBox()),
                            Obx(() =>
                            placedorder.coupenred.isNotEmpty? SizedBox(
                              height: h / 100,
                            ):SizedBox()),

                            applyointlistt.isNotEmpty&& selectedOption=="male" ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "loyalty point appiled",
                                  style: LightText,
                                ),
                                Text(
                                  "- CAD ${applyointlistt[0].toStringAsFixed(4)
                                  }",
                                  style: LightText,
                                )
                              ],
                            ):SizedBox(),
                            applyointlistt.isNotEmpty? SizedBox(
                              height: h / 100,
                            ):SizedBox(),


                            SizedBox(
                              height: h / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Taxes and Charges %",
                                  style: LightText,
                                ),
                                Text(
                                  " ${chargelistt[0][0]["tax"]}",
                                  style: LightText,
                                )
                              ],
                            ),


                            const Divider(),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: A_style_medium,
                                ),
                                Obx(() =>
                                placedorder.coupenred.isNotEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?
                                Text  (
                                  "CAD ${(orderlistt .elementAt(0)[ "grand_total"]+
                                      (orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-
                                      double.parse(applyointlistt[0].toStringAsFixed(4))-
                                      (orderlistt.elementAt(0)[
                                      "grand_total"]* (placedorder.coupenred[0]['discount_price']/100))}",
                                  style: TextStyle(
                                    //letterSpacing: 2.5,
                                    //color: Colors.white,
                                      color: Colors.green.shade700,
                                      fontSize: 14),
                                  maxLines: 2,
                                )
                                    :
                                placedorder.coupenred.isEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?
                                Obx(() =>

                                    Text(
                                      "CAD ${
                                          ((
                                              orderlistt .elementAt(0)[ "grand_total"]+
                                              (orderlistt .elementAt(0)[ "grand_total"]*
                                                  (int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-double.parse(applyointlistt[0].toStringAsFixed(4))
                                          )}",
                                      style: TextStyle(
                                        //letterSpacing: 2.5,
                                        //color: Colors.white,
                                          color: Colors.green.shade700,
                                          fontSize: 14),
                                      maxLines: 2,
                                    )):
                                placedorder.coupenred.isNotEmpty && applyointlistt.isEmpty &&selectedOption==""?
                                Obx(() => Text(
                                  "CAD ${((
                                      orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))
                                      -
                                      (orderlistt.elementAt(0)[
                                      "grand_total"]* (placedorder.coupenred[0]['discount_price']/100))
                                  )}",
                                  style: TextStyle(
                                    //letterSpacing: 2.5,
                                    //color: Colors.white,
                                      color: Colors.green.shade700,
                                      fontSize: 14),
                                  maxLines: 2,
                                )):
                                Text(
                                  "CAD ${((
                                      orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))

                                  )}",
                                  style: TextStyle(
                                    //letterSpacing: 2.5,
                                    //color: Colors.white,
                                      color: Colors.green.shade700,
                                      fontSize: 14),
                                  maxLines: 2,
                                )
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: h / 9,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3)]),
        child: Column(
          children: [
            CustomButton(
              title: 'Proceed to Checkout',
              onTap: () {
                var totalll=
                orderList.contains(0).toString() == "true"?

                orderList.contains(0).toString() == "true"&& placedorder.coupenred.isNotEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?

                      " ${(int.parse(getaddress.deliverychager.value.toString())+orderlistt .elementAt(0)[ "grand_total"]+
                          (orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-
                          double.parse(applyointlistt[0].toStringAsFixed(4))-
                          (orderlistt.elementAt(0)[
                          "grand_total"]* (placedorder.coupenred[0]['discount_price']/100))}"


                        :
                orderList.contains(0).toString() == "true"&& placedorder.coupenred.isEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?



                          " ${
                              ((int.parse(getaddress.deliverychager.value.toString())+
                                  orderlistt .elementAt(0)[ "grand_total"]+
                                  (orderlistt .elementAt(0)[ "grand_total"]*
                                      (int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-double.parse(applyointlistt[0].toStringAsFixed(4))
                              )}"
                        :
                orderList.contains(0).toString() == "true"&& placedorder.coupenred.isNotEmpty && applyointlistt.isEmpty &&selectedOption==""?

                      " ${((int.parse(getaddress.deliverychager.value.toString())+
                          orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))
                          -
                          (orderlistt.elementAt(0)[
                          "grand_total"]* (placedorder.coupenred[0]['discount_price']/100))
                      )}"
                    :
                    " ${((int.parse(getaddress.deliverychager.value.toString())+
                          orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))

                      )}"
                    :

                orderList.contains(0).toString() == "false"&&  placedorder.coupenred.isNotEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?
                "${(orderlistt .elementAt(0)[ "grand_total"]+
                      (orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-
                      double.parse(applyointlistt[0].toStringAsFixed(4))-
                      (orderlistt.elementAt(0)["grand_total"]* (placedorder.coupenred[0]['discount_price']/100))
                }"
                    :
                orderList.contains(0).toString() == "false"&&placedorder.coupenred.isEmpty && applyointlistt.isNotEmpty && selectedOption=="male"?
                "${((orderlistt .elementAt(0)[ "grand_total"]+
                              (orderlistt .elementAt(0)[ "grand_total"]*
                                  (int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))-double.parse(applyointlistt[0].toStringAsFixed(4))
                          )}"
                      :
                orderList.contains(0).toString() == "false"&& placedorder.coupenred.isNotEmpty && applyointlistt.isEmpty &&selectedOption==""?

                  " ${(
                      orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))
                      -
                      (orderlistt.elementAt(0)[
                      "grand_total"]* (placedorder.coupenred[0]['discount_price']/100))
                  }"
                :

                  " ${((
                      orderlistt .elementAt(0)[ "grand_total"]+(orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)))

                  )}";








              if  (orderList.contains(0).toString() == "true" && Addresslist!.isEmpty)
              {
                Utils().sendMassage('Please add address');
              }
              else {
                print(Addresslist[0]["_id"]);
                placedorder.placedorder_api(
                    orderlistt[0]["orderId"],
                    orderList.contains(0).toString() == "true" ? "0" : "1",
                    "${Addresslist[0]["house_no"]}, ${Addresslist[0]["floor_no"]},${Addresslist[0]["building_name"]},${Addresslist[0]["how_to_reach"]},${Addresslist[0]["contact_no"]}",
                    selectedOption2 == 1 ? "${int.parse(getaddress.deliverychager.value.toString())}" : "",
                    applyointlistt.isNotEmpty &&selectedOption == "male" ? "${applipoints}" : "0",
                    placedorder.coupenred.isNotEmpty? (orderlistt.elementAt(0)["grand_total"]* (placedorder.coupenred[0]['discount_price']/100)).toString() :0,
                    chargelistt[0][0]["tax"].toString().replaceAll("%", "").toString(),
                    orderlistt[0]["grand_total"].toString(),
                    totalll.toString()
                    //
                    // orderList.contains(0).toString() == "true"  ?
                    //
                    // " ${int.parse(chargelistt[0][0]["delivery_charge"]) +
                    //     orderlistt.elementAt(0)[ "grand_total"] +
                    //     (orderlistt.elementAt(0)[ "grand_total"] *
                    //         (int.parse(chargelistt[0][0]["tax"]
                    //             .toString()
                    //             .replaceAll("%", "")) / 100))}"
                    //     :
                    // " ${ orderlistt.elementAt(0)[ "grand_total"] +
                    //     (orderlistt.elementAt(0)[ "grand_total"] *
                    //         (int.parse(chargelistt[0][0]["tax"]
                    //             .toString()
                    //             .replaceAll("%", "")) / 100))}"


                    ,
                    widget.cartId.toString()
                );
                //_showAlertDialog(context);
              }
              },
            ),
          ],
        ),
      ),
    );
  }
}


