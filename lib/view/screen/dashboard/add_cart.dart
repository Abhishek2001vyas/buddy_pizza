import 'package:buddy_pizza/view/screen/dashboard/menu_screen.dart';
import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../api/Addtocart_api.dart';
import '../../api/orderplaceed_api.dart';
import '../../controller.dart';
import '../../theme/text2.dart';
import '../../utils/constant.dart';
import '../../utils/utils.dart';
import 'home/your_order.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  String selectedBagItem = 'Delete item';
  final cartlistapi = Get.put(Addtocart_api());
  final conapi = Get.put(PizzaController());
  final addorderapi = Get.put(Orderplaced_api()); // @override
  TextEditingController note = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          "Add to Cart",
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            FutureBuilder(future: cartlistapi.Addtocartist(),
              builder: (context, snapshot) {

                return
                  Obx(() =>
                  cartlistapi.cartlist.isEmpty ?
                  Center(
                    child: Image.asset(
                      "assets/images/output-onlinegiftools.gif",
                      height: h / 2, width: w / 2,),
                  ) :
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${cartlistapi.cartlist.elementAt(
                                  0)[0]["products"].length} items: Total ",
                              style: A_style_mid,
                            ),

                            Text(
                              " CAD ${cartlistapi.totalcartprice.value} ",
                              style: A_style_mid_black,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: cartlistapi.cartlist.elementAt(
                              0)[0]["products"].length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return

                              Column(
                                children: [
                                  Dismissible(
                                    key: Key(cartlistapi.cartlist.elementAt(
                                        0)[0]["products"][index]["_id"]
                                        .toString()),
                                    onDismissed: (direction) async {
                                     await cartlistapi.Addtocartistdelete(
                                          cartlistapi.cartlist.elementAt(
                                              0)[0]["products"][index]["_id"]);
                                    },
                                    background: Container(
                                      color: Colors.red.shade700,
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Icon(
                                            Icons.delete,
                                            size: 35,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              5),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                blurRadius: 1)
                                          ]),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(5),
                                                    child:
                            cartlistapi.cartlist.elementAt(0)[0]["products"][index]["image"]==""?
                            Image.asset(
                              "assets/images/img_3.png", height: h / 8, width: w / 4,fit: BoxFit.cover,
                            ):

                                                    Image.network(
                                                      "$user_image_url${cartlistapi
                                                          .cartlist.elementAt(
                                                          0)[0]["products"][index]["image"]}",
                                                      height: h / 8,
                                                      width: w / 4,
                                                      fit: BoxFit.cover,
                                                    )),
                                                SizedBox(
                                                  width: w / 80,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: w / 1.6,
                                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(width: w / 2.9,
                                                            child: Text(
                                                              cartlistapi.cartlist
                                                                  .elementAt(
                                                                  0)[0]["products"][index]["product_name"] ??
                                                                  "",
                                                              style: A_style_medium,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          cartlistapi
                                                              .cartlist
                                                              .elementAt(
                                                              0)[0]["products"][index]["flavour"]!=null || cartlistapi
                                                              .cartlist
                                                              .elementAt(
                                                              0)[0]["products"][index]["flavour"]=="" ?
                                                          GestureDetector(
                                                              onTap: (){
                                                                Get.defaultDialog(title: "Deatils",
                                                                    content: Column(
                                                                      children: [

                                                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text( "flavour name : ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["flavour"]}")





                                                                          ],)
                                                                      ],
                                                                    )

                                                                );
                                                              },
                                                              child: Text("Deatils",style: TextStyle(color: Colors.red),)):
                                                          cartlistapi
                                                              .cartlist
                                                              .elementAt(
                                                              0)[0]["products"][index]["topings_name"].isEmpty?SizedBox():
                                                          GestureDetector(
                                                              onTap: (){
                                                                Get.defaultDialog(title: "Deatils",
                                                                content: Column(
                                                                  children: [
                                                                    cartlistapi
                                                                        .cartlist
                                                                        .elementAt(
                                                                        0)[0]["products"][index]["topings_name"].isEmpty?SizedBox():
                                                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [

                                                                            Text( "crust name : ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["crust_name"]}")
                                                                        ,
                                                                            Text( " crust price: CAD ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["crust_price"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["dips_name"]==null?SizedBox():
                                                                          Text( "dips name:  ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["dips_name"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["dips_price"]==null?SizedBox():
                                                                            Text( "dips price: CAD ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["dips_price"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["souce_name"]==null?SizedBox():
                                                                            Text( "sauce name: ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["souce_name"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["souce_price"]==null?SizedBox():
                                                                            Text( "sauce price: CAD ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["souce_price"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["meats_name"]==null?SizedBox():
                                                                            Text( "meats name: ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["meats_name"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["meats_price"]==null?SizedBox():
                                                                            Text( "meats price: CAD ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["meats_price"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["veggies_name"]==null?SizedBox():
                                                                            Text( "veggies name: ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["veggies_name"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["veggies_price"]==null?SizedBox():
                                                                            Text( "veggies price: CAD ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["veggies_price"]}"),
                                                                            cartlistapi.cartlist .elementAt(0)[0]["products"][index]["topings_name"]==null?SizedBox():
                                                                            Text( "topings_name: ${cartlistapi.cartlist .elementAt(0)[0]["products"][index]["topings_name"].toString().substring(1,)}"),





                                                                        ],)
                                                                ],
                                                                )

                                                                );
                                                              },
                                                              child: Text("Deatils",style: TextStyle(color: Colors.red),))
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h / 200,
                                                    ),
                                                    Text(
                                                      "CAD ${cartlistapi
                                                          .cartlist.elementAt(
                                                          0)[0]["products"][index]["cart_price"].toString()}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: "Amazon_med"),
                                                    ),
                                                    SizedBox(
                                                      height: h / 100,
                                                    ),
                                                    GetBuilder<PizzaController>(
                                                        builder:
                                                            (
                                                            PizzaController controller) {
                                                          return Container(
                                                            width: w / 2,
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5),

                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () async {
                                                                    // await controller.decrement();
                                                                    // cartlistapi.subdd(controller.counter);
                                                                    var quantity = cartlistapi
                                                                        .cartlist
                                                                        .elementAt(
                                                                        0)[0]["products"][index]["order_quantity"];
                                                                    if (quantity >
                                                                        1) {
                                                                      quantity =
                                                                          cartlistapi
                                                                              .cartlist
                                                                              .elementAt(
                                                                              0)[0]["products"][index]["order_quantity"] -
                                                                              1;
                                                                      print(
                                                                          "ggggg" +
                                                                              quantity
                                                                                  .toString());
                                                                      cartlistapi
                                                                          .Addtocartistupadatesub(

                                                                          cartlistapi
                                                                              .cartlist
                                                                              .elementAt(
                                                                              0)[0]["products"][index]["order_quantity"],
                                                                          cartlistapi
                                                                              .cartlist
                                                                              .elementAt(
                                                                              0)[0]["products"][index]["_id"],
                                                                          quantity,
                                                                          cartlistapi
                                                                              .cartlist
                                                                              .elementAt(
                                                                              0)[0]["products"][index]["cart_price"] ??
                                                                              0);
                                                                    }
                                                                    else {
                                                                      Utils()
                                                                          .alertbox(
                                                                          "Please delete this product from add cart"
                                                                              " swipe right to left"
                                                                      );
                                                                    }
                                                                    ;
                                                                    print(
                                                                        quantity);
                                                                  },
                                                                  child: Container(width: w/7,height: h/25,
                                                                    // margin:
                                                                    // const EdgeInsets
                                                                    //     .all(4),
                                                                    // padding:
                                                                    // const EdgeInsets
                                                                    //     .all(4),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            3),
                                                                        border: Border
                                                                            .all(
                                                                            color:
                                                                            Colors
                                                                                .grey)),
                                                                    child: Center(
                                                                      child:
                                                                      Text(
                                                                        "-",
                                                                        style:  TextStyle(
                                                                          //letterSpacing: 1.5,
                                                                          //color: Colors.white,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: Colors.black,
                                                                            // fontFamily: "Amazon_med",
                                                                            fontSize: 20),
                                                                        maxLines: 2,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Obx(() =>
                                                                cartlistapi
                                                                    .cartlist
                                                                    .isEmpty
                                                                    ?
                                                                Center(
                                                                  child: CircularProgressIndicator(),)
                                                                    :
                                                                Text(
                                                                  cartlistapi
                                                                      .cartlist
                                                                      .elementAt(
                                                                      0)[0]["products"][index]["order_quantity"]
                                                                      .toString()
                                                                  //"${controller.counter}"
                                                                  ,
                                                                  style: const TextStyle(fontSize: 20,
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                                )
                                                                ,
                                                                InkWell(
                                                                  onTap: () {
                                                                    var quantity = cartlistapi
                                                                        .cartlist
                                                                        .elementAt(
                                                                        0)[0]["products"][index]["order_quantity"];
                                                                    quantity =
                                                                        cartlistapi
                                                                            .cartlist
                                                                            .elementAt(
                                                                            0)[0]["products"][index]["order_quantity"] +
                                                                            1;
                                                                    print(
                                                                        "ggggg" +
                                                                            quantity
                                                                                .toString());
                                                                    cartlistapi
                                                                        .Addtocartistupadateadd(
                                                                        cartlistapi
                                                                            .cartlist
                                                                            .elementAt(
                                                                            0)[0]["products"][index]["order_quantity"],
                                                                        cartlistapi
                                                                            .cartlist
                                                                            .elementAt(
                                                                            0)[0]["products"][index]["_id"],
                                                                        quantity,
                                                                        cartlistapi
                                                                            .cartlist
                                                                            .elementAt(
                                                                            0)[0]["products"][index]["cart_price"]);
                                                                    // controller.increment();
                                                                  },
                                                                  child: Container(width: w/7,height: h/25,
                                                                    // margin:
                                                                    // const EdgeInsets
                                                                    //     .all(4),
                                                                    // padding:
                                                                    // const EdgeInsets
                                                                    //     .all(4),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            3),
                                                                        border: Border
                                                                            .all(
                                                                            color:
                                                                            Colors
                                                                                .grey)),
                                                                    child: Center(
                                                                      child: Text(
                                                                        "+",
                                                                        style: TextStyle(
                                                                          //letterSpacing: 1.5,
                                                                          //color: Colors.white,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontWeight: FontWeight.w500,
                                                                            color: Colors.black,
                                                                            // fontFamily: "Amazon_med",
                                                                            fontSize: 20),

                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }),

                                                    const Row(
                                                      children: [],
                                                    ),

                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: h / 70,
                                  ),
                                ],
                              );
                          }),
                      SizedBox(
                        height: h / 90,
                      ),
                      Text('Note * Optional'),
                      SizedBox(
                        height: h / 150,
                      ),
                      TextFormField(

                        decoration: InputDecoration(border: OutlineInputBorder(),),
                        // style: TextStyle(decoration: TextDecoration.none),
                        maxLines: 5,
                      ),
                    ],
                  ))
                ;
              },),


            SizedBox(
              height: h / 50,
            ),

          ])),
      bottomNavigationBar:
      Obx(() =>  cartlistapi.cartlist.isEmpty ?
          SizedBox():
      Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        height: h / 13,
        decoration: const BoxDecoration(color: Colors.white),
        child: InkWell(
          onTap: () async {
            print("kjhgnnknjk${ cartlistapi.cartlist.elementAt(0)[0]["_id"]}");
            await addorderapi.addOrder(
              cartlistapi.cartlist.elementAt(0)[0]["_id"],
              cartlistapi.totalcartprice.value,
              cartlistapi.cartlist.elementAt(0)[0]["products"].length,
              note.text.toString(),);
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            child: _isLoading
                ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
                : Center(
              child: Text(
                "Check out",
                style: TextBold,
              ),
            ),
          ),
        ),
      )),


    );
  }
}
