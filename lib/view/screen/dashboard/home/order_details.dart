import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/Addtocart_api.dart';
import '../../../api/subcategorieslist_api.dart';
import '../../../controller.dart';
import '../../../theme/color.dart';
import '../../../theme/text2.dart';
import '../../../utils/constant.dart';



class OrderDetails extends StatefulWidget {
  final index;

  const OrderDetails({super.key, this.index});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

var myTitle;

class _OrderDetailsState extends State<OrderDetails> {
  PizzaController controller = Get.put(PizzaController());
  final Addtocart = Get.put(Addtocart_api());

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      myTitle = widget.index;
    });
    print("ssss" + myTitle.runtimeType.toString());
    super.initState();
  }

  late var selectedOption =
      productlist.elementAt(0)[myTitle]["size_name"][0]["size"];

  var sizeprice = 0;
  var curstprice = 0;
  var dipsprice = 0;
  var selectedOption2 = curstlist.elementAt(0)[0]["name"];
  List selectedOption1 = ["\" ${topinslist.elementAt(0)[0]["name"]}\" "];
  bool checkedValue = true;
  bool _isChanged = true;
  List selectedOption1price=[];
  List Addproduct = [];
  var cart_price=0.0;var cart_price1;

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
                      "$user_image_url${productlist.elementAt(0)[widget.index]["product_image"]}",
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
                          productlist.elementAt(0)[widget.index]
                                  ["product_name"] ??
                              "",
                          style: TextBold,
                        ),
                        Text(
                          productlist.elementAt(0)[widget.index]
                                  ["description"] ??
                              "",
                          style: TextStyle(
                              //letterSpacing: 2,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,

                              //  fontFamily: "Amazon_med",
                              fontSize: 14),
                          maxLines: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: w / 2.5,
                  top: h/30,
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
                    itemCount: productlist
                        .elementAt(0)[widget.index]["size_name"]
                        .length,
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
                              value: productlist.elementAt(0)[widget.index]
                                  ["size_name"][index]["size"],
                              groupValue: selectedOption ??
                                  productlist.elementAt(0)[widget.index]
                                      ["size_name"][0]["size"],
                              onChanged: (value) {
                                setState(() {
                                  selectedOption1price.clear();
                                  selectedOption1.clear();
                                  selectedOption1.add("\" ${topinslist.elementAt(0)[0]["name"]}\" ");
                                  selectedOption = value;
                                  sizeprice = index;
                                  print("Button value: $value");
                                  print(
                                      "selectedOption value: $selectedOption");
                                });
                              },
                            ),
                          ),
                          SizedBox(
                              width: w / 1.7,
                              child: Text(productlist.elementAt(0)[widget.index]
                                      ["size_name"][index]["size"] ??
                                  "")),
                          const Spacer(),
                          Text("CAD " +
                                  productlist.elementAt(0)[widget.index]
                                      ["size_name"][index]["price"] ??
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
                                  curstprice = index;
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
                  Text("Add Toppings", style: A_style_medium),
                  SizedBox(height: h/150),
                  Text("You Add mutiple toppings & first 3 topping are free",style: TextStyle(color: Colors.grey,fontSize: 12)),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                    topinslist.elementAt(0).length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: Checkbox(shape: CircleBorder(),
                              activeColor: primaryColor,

                              value: selectedOption1.contains("\" ${topinslist.elementAt(0)[index]["name"]}\" "),
                              // toggleable: true,
                              // groupValue: selectedOption1.contains(topinslist.elementAt(0)[index]["name"])
                              //     ,
                              onChanged: (value) {
                                print("yyy${index}");
                                if(value==true){
                                  if(selectedOption1.length>=3){
                                    if(selectedOption1.length==3){
                                      Get.defaultDialog(
                                          title: "Alert",
                                          content: Text("Only the first 3 are free, the rest are paid")
                                      );
                                    }
                                    // selectedOption=="Medium" ||selectedOption=="medium"?
                                    setState(() {
                                      selectedOption1price.add(index);
                                    });
                                // :
                                //     selectedOption=="Large" ||selectedOption=="large"?
                                //     setState(() {
                                //       selectedOption1price.add(topinslist.elementAt(0)[index]["large_price"]);
                                //     }):
                                //     setState(() {
                                //       selectedOption1price.add(topinslist.elementAt(0)[index]["small_price"]);
                                //     });
                                    print("price${selectedOption1price}");
                                  }

                                setState(() {
                                  selectedOption1.add("\" ${topinslist.elementAt(0)[index]["name"]}\" ") ;
                                  print(
                                      "Button value: $value");
                                });
                                }
                                else{
                                  if(selectedOption1.length>3){
                                    setState(() {
                                      selectedOption1price.remove(index) ;
                                    });
                                  }
                                  setState(() {
                                    selectedOption1.remove("\" ${topinslist.elementAt(0)[index]["name"]}\" ") ;
                                  });

                                }
                                print("price${selectedOption1price}");
                                print("oiuyttr${ selectedOption1}");
                              },
                            ),
                          ),
                          SizedBox(
                              width: w / 1.2,
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  SizedBox( width: w / 1.65,
                                    child: Text(topinslist.elementAt(
                                        0)[index]
                                    ["name"] ??
                                        ""),
                                  ),
                                  selectedOption=="Medium" ||selectedOption=="medium"?
                                  Text("CAD "+topinslist.elementAt(
                                      0)[index]
                                  ["medium_price"] ??
                                      ""):
                                  selectedOption=="Large" ||selectedOption=="large"?
                                  Text("CAD "+topinslist.elementAt(
                                      0)[index]
                                  ["large_price"] ??
                                      ""):
                                  Text("CAD "+topinslist.elementAt(
                                      0)[index]
                                  ["small_price"] ??
                                      "")
                                ],
                              )),
                        ],
                      );
                    },
                  ),

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
                      Addproduct.clear();
                      print("pppppppppp ${selectedOption1.length} ${selectedOption1price.length}");
                      if(selectedOption1.length>3){
   var pricelength= selectedOption1price.length;
   for (int i=0;i<pricelength;i++){

         var indexxx = selectedOption1price[i];
         print("indexxxx ${indexxx}");
         selectedOption=="Medium" ||selectedOption=="medium"?
     cart_price +=  double.parse(topinslist.elementAt(0)[indexxx] ["medium_price"]??0.0):
         selectedOption=="Large" ||selectedOption=="large"?
         cart_price +=  double.parse(topinslist.elementAt(0)[indexxx] ["large_price"]??0.0)
       : cart_price +=  double.parse(topinslist.elementAt(0)[indexxx] ["small_price"]??0.0);

print("carttt ${cart_price}");
    };

   };



                      print("cartxxx ${cart_price}");
                      cart_price1 = cart_price + double.parse(productlist.elementAt(0)[widget.index]
                      ["size_name"][sizeprice]["price"]) +
                          double.parse( curstlist.elementAt(0)[curstprice]["price"]);
                      var pppp = cart_price1;
                      print("ppppppcartprice1${cart_price1}");
                      Addproduct.add({
                        'productId': productlist
                            .elementAt(0)[widget.index]["_id"]
                            .toString(),
                        "product_name": productlist.elementAt(0)[widget.index]
                                ["product_name"] ??
                            "",
                        "order_quantity": controller.counter,
                        "product_size": selectedOption ?? "",
                        "product_price": productlist.elementAt(0)[widget.index]
                                ["size_name"][sizeprice]["price"] ??
                            "",
                        "crust_name": selectedOption2 ?? "",
                        "crust_price":
                            curstlist.elementAt(0)[curstprice]["price"] ?? "",
                        "topings_name": selectedOption1 ?? "",
                        "topings_price":
                        cart_price.toString() ?? "",
                        "cart_price": pppp ?? "",
                        "image": productlist.elementAt(0)[widget.index]
                                ["product_image"] ??
                            ''
                      });
                      Addtocart.Addtocart(Addproduct);
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
            SizedBox(
              height: h / 70,
            ),
          ],
        ),
      ),
    );
  }
}
