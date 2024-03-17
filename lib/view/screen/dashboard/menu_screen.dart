import 'package:buddy_pizza/view/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/Addtocart_api.dart';
import '../../api/homebanner_api.dart';
import '../../api/subcategorieslist_api.dart';
import '../../controller.dart';
import '../../theme/color.dart';
import '../../theme/text2.dart';
import 'home/order_details.dart';
import 'home/your_order.dart';

dynamic menuItemList = 0;

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  PizzaController controller = Get.put(PizzaController());
  final subcatergoriesapi = Get.put(Subcategories_api());
  List Addproduct = [];
  final Addtocart = Get.put(Addtocart_api());
  final String _selectedItem = 'Size 9';
  var selectedOption;
  bool checkedValue = true;
  String? valueChoose;
  List<String> listitem = [];
  bool isDarkMode = false;
  var selectedOption3;var selectedOption2;
  var selectedOption1;
  var selectedOption4; var selectedOption5;var selectedOption51;
  var selectedOption6; var selectedOption61; var selectedOption7;
  var selectedOption71; var wingsorbeverage; var cart_price;
  var cart_price11=0.0;
var  cart_price1=0.0;
var selectedOption611 =0;var selectedOption111 =0;var selectedOption011 =0;
  var selectedOption311 =0;var selectedOption211 =0;
  var selectedOption411 =0;var selectedOption511 =0;

  List selectedOption11 = [];
 // List selectedOption11 = [topinslist.elementAt(0)[0]["name"].toString()];
  List selectedOption1price=[];

// @override
//   void initState() {
//     // TODO: implement initState
//   selectedOption11.add("\" ${topinslist.elementAt(0)[0]["name"]}\" ");
//     super.initState();
//   }
  // List Addproduct = [];
  // var cart_price;
  String dropdownvalue = "BBQ(Mild)";

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        toolbarHeight: h / 6,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Menu",
            ),
            SizedBox(
              height: h / 90,
            ),
            SizedBox(
              width: w,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      height: h / 16,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            menuItemList = -1;
                          });
                        },
                        child: Material(borderRadius: BorderRadius.circular(8),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              color: menuItemList == -1
                                  ? Colors.red
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),

                              border: menuItemList == -1
                                  ? Border.all(color: Colors.red)
                                  : Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              "Create your own ",
                              style: menuItemList == -1
                                  ? const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)
                                  : const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 16,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cate.elementAt(0).length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  menuItemList = index;
                                });
                              },
                              child: Material(borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: menuItemList == index
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),

                                    border: menuItemList == index
                                        ? Border.all(color: Colors.red)
                                        : Border.all(color: Colors.grey),
                                  ),
                                  child: Text(
                                    cate.elementAt(0)[index]["category_name"],
                                    style: menuItemList == index
                                        ? const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700)
                                        : const TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h / 90,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            menuItemList == -1
                ? FutureBuilder(
                    future: subcatergoriesapi.product1(),
                    builder: (context, snapshot) {
                      print("ppp23232");
                      selectedOption11.add("\" ${topinslist.elementAt(0)[0]["name"]}\" ");
                      return
                        sizelist.isEmpty || topinslist.isEmpty ||curstlist.isEmpty || sourceist.isEmpty ||veggielist.isEmpty || meatlist.isEmpty
                          ? Center(
                              child: Image.asset(
                                "assets/images/output-onlinegiftools.gif",
                                height: h / 2,
                                width: w / 2,
                              ),
                            )
                          :
                        Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Create your Own",
                                  style: Text_Lit_Bold,
                                ),
                                SizedBox(
                                  height: h / 50,
                                ),
                                Text("Choose the Size", style: A_style_medium),
                                ListView.builder(
                                  itemCount: sizelist.elementAt(0).length,
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
                                            value: sizelist.elementAt(0)[index]
                                                ["size"],
                                            groupValue: selectedOption ??
                                                sizelist.elementAt(0)[0]
                                                    ["size"],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedOption1price.clear();
                                                selectedOption11.clear();
                                                selectedOption11.add("\" ${topinslist.elementAt(0)[0]["name"]}\" ");
                                                selectedOption = value;
                                                selectedOption011 = index;
                                                print("Button value: $value");
                                                print(
                                                    "selectedOption value: $selectedOption");
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                            width: w / 1.7,
                                            child: Text(
                                                sizelist.elementAt(0)[index]
                                                        ["size"] ??
                                                    "")),
                                        const Spacer(),
                                        Text("CAD " +
                                                sizelist.elementAt(0)[index]
                                                    ["price"] ??
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
                                            value: curstlist.elementAt(0)[index]
                                                ["name"],
                                            groupValue: selectedOption2 ??
                                                curstlist.elementAt(0)[0]
                                                    ["name"],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedOption2 = value;
                                                selectedOption211 = index;
                                                print("Button value: $value");
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                            width: w / 1.7,
                                            child: Text(
                                                curstlist.elementAt(0)[index]
                                                        ["name"] ??
                                                    "")),
                                        const Spacer(),
                                        Text("CAD " +
                                                curstlist.elementAt(0)[index]
                                                    ["price"] ??
                                            ""),
                                      ],
                                    );
                                  },
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title:
                                        Text("Add Dips", style: A_style_medium),
                                    children: [
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
                                                  value: diplist.elementAt(
                                                      0)[index]["name"],
                                                  groupValue: selectedOption1 ??
                                                      diplist.elementAt(0)[0]
                                                          ["name"],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedOption1 = value;
                                                      selectedOption111 = index;
                                                      print(
                                                          "Button value: $value");
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                  width: w / 1.7,
                                                  child: Text(diplist.elementAt(
                                                          0)[index]["name"] ??
                                                      "")),
                                              const Spacer(),
                                              Text("CAD " +
                                                      diplist.elementAt(
                                                          0)[index]["price"] ??
                                                  ""),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title: Text("Add Sauces",
                                        style: A_style_medium),
                                    children: [
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            sourceist.elementAt(0).length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                width: 35,
                                                child: Radio(
                                                  activeColor: primaryColor,
                                                  value: sourceist.elementAt(
                                                      0)[index]["name"],
                                                  groupValue: selectedOption5 ??
                                                      sourceist.elementAt(0)[0]
                                                          ["name"],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedOption5 = value;
                                                      selectedOption511=index;
                                                      print(
                                                          "Button value: $value");
                                                    });
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
                                                        child: Text(sourceist.elementAt(
                                                            0)[index]
                                                        ["name"] ??
                                                            ""),
                                                      ),
                                                      selectedOption=="Medium" ||selectedOption=="medium"?
                                                      Text("CAD "+sourceist.elementAt(
                                                          0)[index]
                                                      ["medium_price"] ??
                                                          ""):
                                                      selectedOption=="Large" ||selectedOption=="large"?
                                                      Text("CAD "+sourceist.elementAt(
                                                          0)[index]
                                                      ["large_price"] ??
                                                          ""):
                                                      Text("CAD "+sourceist.elementAt(
                                                          0)[index]
                                                      ["small_price"] ??
                                                          "")

                                                    ],
                                                  )),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title:
                                        Text("Add Meat", style: A_style_medium),
                                    children: [
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: meatlist.elementAt(0).length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                width: 35,
                                                child: Radio(
                                                  activeColor: primaryColor,
                                                  value: meatlist.elementAt(
                                                      0)[index]["name"],
                                                  groupValue: selectedOption3 ??
                                                      meatlist.elementAt(0)[0]
                                                          ["name"],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedOption3 = value;
                                                      selectedOption311=index;
                                                      print(
                                                          "Button value: $value");
                                                    });
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
                                                        child: Text(meatlist.elementAt(
                                                            0)[index]
                                                        ["name"] ??
                                                            ""),
                                                      ),
                                                      selectedOption=="Medium" ||selectedOption=="medium"?
                                                      Text("CAD "+meatlist.elementAt(
                                                          0)[index]
                                                      ["medium_price"] ??
                                                          ""):
                                                      selectedOption=="Large" ||selectedOption=="large"?
                                                      Text("CAD "+meatlist.elementAt(
                                                          0)[index]
                                                      ["large_price"] ??
                                                          ""):
                                                      Text("CAD "+meatlist.elementAt(
                                                          0)[index]
                                                      ["small_price"] ??
                                                          "")

                                                    ],
                                                  )),

                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title: Text("Add Veggies",
                                        style: A_style_medium),
                                    children: [
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            veggielist.elementAt(0).length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                width: 35,
                                                child: Radio(
                                                  activeColor: primaryColor,
                                                  value: veggielist.elementAt(
                                                      0)[index]["name"],
                                                  groupValue: selectedOption6 ??
                                                      veggielist.elementAt(0)[0]
                                                          ["name"],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedOption6 = value;
                                                      selectedOption611 = index;
                                                      print(
                                                          "Button value: $value");
                                                    });
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
                                                        child: Text(veggielist.elementAt(
                                                            0)[index]
                                                        ["name"] ??
                                                            ""),
                                                      ),
                                                      selectedOption=="Medium" ||selectedOption=="medium"?
                                                      Text("CAD "+veggielist.elementAt(
                                                          0)[index]
                                                      ["medium_price"] ??
                                                          ""):
                                                      selectedOption=="Large" ||selectedOption=="large"?
                                                      Text("CAD "+veggielist.elementAt(
                                                          0)[index]
                                                      ["large_price"] ??
                                                          ""):
                                                      Text("CAD "+veggielist.elementAt(
                                                          0)[index]
                                                      ["small_price"] ??
                                                          "")

                                                    ],
                                                  )),

                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title: Text("Add Topins",
                                        style: A_style_medium),expandedCrossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

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

                                                  value: selectedOption11.contains("\" ${topinslist.elementAt(0)[index]["name"]}\" " ),
                                                  // toggleable: true,
                                                  // groupValue: selectedOption1.contains(topinslist.elementAt(0)[index]["name"])
                                                  //     ,
                                                  onChanged: (value) {
                                                    print("yyy${index}");
                                                    if(value==true){
                                                      if(selectedOption11.length>=3){
                                                        if(selectedOption11.length==3){
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
                                                        selectedOption11.add( "\" ${topinslist.elementAt(0)[index]["name"]}\" " ) ;
                                                        print(
                                                            "Button value: $value");
                                                      });
                                                    }
                                                    else{
                                                      if(selectedOption11.length>3){
                                                        setState(() {
                                                          selectedOption1price.remove(index) ;
                                                        });
                                                      }
                                                      setState(() {
                                                        selectedOption11.remove("\" ${topinslist.elementAt(0)[index]["name"]}\" ") ;
                                                      });

                                                    }
                                                    print("price${selectedOption1price}");
                                                    print("oiuyttr${ selectedOption11}");
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
                                    ],
                                  ),
                                ),
                                // Obx(() => )
                                // Row(
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.only(
                                //           top: 8.0, bottom: 8),
                                //       child: Container(
                                //         width: w / 1.1,
                                //         decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius:
                                //                 BorderRadius.circular(20),
                                //             boxShadow: [
                                //               BoxShadow(
                                //                   color: Colors.grey.shade300,
                                //                   blurRadius: 3)
                                //             ]),
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             InkWell(
                                //               onTap: () {
                                //                 controller.decrement();
                                //               },
                                //               child: Container(
                                //                   width: 40,
                                //                   decoration:
                                //                       const BoxDecoration(
                                //                     color: Colors.black,
                                //                     borderRadius:
                                //                         BorderRadius.only(
                                //                             topLeft: Radius
                                //                                 .circular(20),
                                //                             bottomLeft:
                                //                                 Radius.circular(
                                //                                     20)),
                                //                   ),
                                //                   child: const Text(
                                //                     "-",
                                //                     style: TextStyle(
                                //                         fontSize: 25,
                                //                         color: Colors.white,
                                //                         fontWeight:
                                //                             FontWeight.bold),
                                //                     textAlign: TextAlign.center,
                                //                   )),
                                //             ),
                                //             Obx(() => Text(
                                //                   "QTy:${controller.counter.value.toInt()}",
                                //                   style: const TextStyle(
                                //                       color: Colors.black),
                                //                 )),
                                //             InkWell(
                                //               onTap: () {
                                //                 controller.increment();
                                //               },
                                //               child: Container(
                                //                   width: 40,
                                //                   decoration:
                                //                       const BoxDecoration(
                                //                     color: Colors.black,
                                //                     borderRadius:
                                //                         BorderRadius.only(
                                //                             topRight: Radius
                                //                                 .circular(20),
                                //                             bottomRight:
                                //                                 Radius.circular(
                                //                                     20)),
                                //                   ),
                                //                   child: const Text(
                                //                     "+",
                                //                     style: TextStyle(
                                //                         fontSize: 25,
                                //                         color: Colors.white,
                                //                         fontWeight:
                                //                             FontWeight.bold),
                                //                     textAlign: TextAlign.center,
                                //                   )),
                                //             )
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: h / 80,
                                ),
                                InkWell(
                                  onTap: () {
                                    Addproduct.clear();
                                    print("pppppppppp ${selectedOption11.length} ${selectedOption1price.length}");
                                    var veggieprice;
                                    // var crustprice;
                                    var meatprice;
                                    var dipsprice; var saucesprice;

                                    /*toppines price*/
                                    if(selectedOption11.length>3){
                                      var pricelength= selectedOption1price.length;
                                      for (int i=0;i<pricelength;i++){

                                        var indexxx = selectedOption1price[i];
                                        print("indexxxx ${indexxx}");
                                        selectedOption=="Medium" ||selectedOption=="medium"?
                                        cart_price11 +=  double.parse(topinslist.elementAt(0)[indexxx] ["medium_price"]??0.0):
                                        selectedOption=="Large" ||selectedOption=="large"?
                                        cart_price11 +=  double.parse(topinslist.elementAt(0)[indexxx] ["large_price"]??0.0)
                                            : cart_price11 +=  double.parse(topinslist.elementAt(0)[indexxx] ["small_price"]??0.0);

                                        print("carttt ${cart_price11.toString()}");
                                      };

                                    };
                                    print("cartxxx ${cart_price11}");

                                    /*veggies price*/
                                    selectedOption=="Medium" ||selectedOption=="medium"?
                                         veggieprice=veggielist.elementAt(
                                            0)[selectedOption611]
                                        ["medium_price"]??00.0:
                                    selectedOption=="Large" ||selectedOption=="large"?
                                    veggieprice=veggielist.elementAt(
                                        0)[selectedOption611]
                                    ["large_price"]??00.0: veggieprice=veggielist.elementAt(
                                        0)[selectedOption611]
                                    ["small_price"]??00.0;

                                    /*meat price*/
                                    selectedOption=="Medium" ||selectedOption=="medium"?
                                    meatprice=meatlist.elementAt(
                                        0)[selectedOption311]
                                    ["medium_price"]??00.0:
                                    selectedOption=="Large" ||selectedOption=="large"?
                                    meatprice=meatlist.elementAt(
                                        0)[selectedOption311]
                                    ["large_price"]??00.0:
                                    meatprice=meatlist.elementAt(
                                        0)[selectedOption311]
                                    ["small_price"]??00.0;

                                    print("dsafg ${selectedOption511}");
                                    /*sauces price*/
                                    selectedOption=="Medium" ||selectedOption=="medium"?
                                    saucesprice=sourceist.elementAt(
                                        0)[selectedOption511]
                                    ["medium_price"]??00.0:
                                    selectedOption=="Large" ||selectedOption=="large"?
                                    saucesprice=veggielist.elementAt(
                                        0)[selectedOption511]
                                    ["large_price"]??00.0:
                                    saucesprice=veggielist.elementAt(
                                        0)[selectedOption511]
                                    ["small_price"]??00.0;

                                    // /*dips price*/
                                    // selectedOption=="Medium" ||selectedOption=="medium"?
                                    // dipsprice=veggielist.elementAt(
                                    //     0)[selectedOption6]
                                    // ["medium_price"]:
                                    // selectedOption=="Large" ||selectedOption=="large"?
                                    // dipsprice=veggielist.elementAt(
                                    //     0)[selectedOption6]
                                    // ["large_price"]: dipsprice=veggielist.elementAt(
                                    //     0)[selectedOption6]
                                    // ["small_price"];
                                    //
                                    // /*curst price*/
                                    // selectedOption=="Medium" ||selectedOption=="medium"?
                                    // crustprice=curstlist.elementAt(0)[index]
                                    // ["price"]:
                                    // selectedOption=="Large" ||selectedOption=="large"?
                                    // crustprice=curstlist.elementAt(0)[index]
                                    // ["price"]: crustprice=curstlist.elementAt(0)[index]
                                    // ["price"];


                                    cart_price1 = cart_price11 + int.parse(sizelist.elementAt(0)[selectedOption011]
                                    ["price"]??00) +
                                        double.parse( curstlist.elementAt(0)[  selectedOption211] ["price"] ??0.00)
                                    + double.parse( veggieprice)+
                                        double.parse( saucesprice)
                                        + double.parse( meatprice)+
                                        double.parse( diplist.elementAt(
                                            0)[selectedOption111]["price"])
                                    ;




                                    var pppp = cart_price1;
                                    print("ppppppcartprice1 ${cart_price1}");

                                    Addproduct.add({
                                      "product_name": "Create your own",
                                      "product_size": selectedOption ?? "",
                                      "product_price": pppp.toString(),
                                      "crust_name": selectedOption2 ?? "",
                                      "crust_price":curstlist.elementAt(0)[selectedOption211]["price"] ?? "",
                                      "topings_name": selectedOption11 ?? "",
                                      "cart_price": pppp ?? "",
                                      "dips_name":diplist.elementAt( 0)[selectedOption111] ["name"],
                                      "dips_price": diplist.elementAt( 0)[selectedOption111]["price"],
                                      "souce_name":sourceist.elementAt( 0)[selectedOption511] ["name"],
                                      "souce_price":saucesprice,
                                      "meats_name":meatlist.elementAt( 0)[selectedOption311] ["name"],
                                      "meats_price":meatprice,
                                      "veggies_name":veggielist.elementAt( 0)[selectedOption611] ["name"],
                                      "veggies_price":veggieprice,
                                      "image": productlist.elementAt(0)[0]
                                      ["product_image"] ??
                                          ''
                                    });
                                    Addtocart.Addtocartforcreateown(Addproduct);
                                    // Get.to(() => const YourOrder());
                                  },
                                  child: Container(
                                    width: w,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      "Add to Order",
                                      style: TextBold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                                // Text("Add Dips", style: A_style_medium),
                                // ListView.builder(physics: NeverScrollableScrollPhysics(),
                                //   itemCount: diplist.elementAt(0).length,
                                //   shrinkWrap: true,
                                //   itemBuilder: (context, index) {
                                //     return  Row(
                                //       children: [
                                //         SizedBox(
                                //           height: 35,
                                //           width: 35,
                                //           child: Radio(
                                //             activeColor: primaryColor,
                                //             value: diplist.elementAt(0)[index]["name"],
                                //             groupValue: selectedOption1 ?? diplist.elementAt(0)[0]["name"],
                                //             onChanged: (value) {
                                //               setState(() {
                                //                 selectedOption1 = value;
                                //                 print("Button value: $value");
                                //               });
                                //             },
                                //           ),
                                //         ),
                                //         SizedBox(
                                //             width: w/1.7,
                                //             child: Text(diplist.elementAt(0)[index]["name"]??"")),
                                //         const Spacer(),
                                //         Text("CAD "+diplist.elementAt(0)[index]["price"]??""),
                                //       ],
                                //     );
                                //   },),
                              ],
                            );
                    },
                  )
                : FutureBuilder(
                    future: subcatergoriesapi
                        .product(cate.elementAt(0)[menuItemList]["categoryId"]),
                    builder: (context, snapshot) {
                      return productlist.isEmpty
                          ? Center(
                              child: Image.asset(
                                "assets/images/output-onlinegiftools.gif",
                                height: h / 2,
                                width: w / 2,
                              ),
                            )
                      /*Combo deal*/
                          : productlist.elementAt(0)[0]["combo"].isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8, top: 12),
                                  child: ListView.builder(
                                      itemCount:
                                          productlist.elementAt(0).length,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Column(
                                          children: [
                                            Material(
                                              elevation: 2,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Container(
                                                height: h / 4,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                Image.network(
                                                              "$user_image_url${cate.elementAt(0)[menuItemList]["category_logo"]}",
                                                              height: h / 4,
                                                              width: w / 3,
                                                              fit: BoxFit.cover,
                                                            )),
                                                        SizedBox(
                                                          width: w / 40,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            SizedBox(
                                                              width: w / 2.9,
                                                              child: Text(
                                                                productlist.elementAt(0)[index]
                                                                            [
                                                                            "combo"][0]
                                                                        [
                                                                        "combo_name"] ??
                                                                    "",
                                                                style:
                                                                    A_style_medium,
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    h / 150),
                                                            Text(
                                                              productlist.elementAt(
                                                                              0)[index]
                                                                          [
                                                                          "combo"][0]
                                                                      [
                                                                      "combo_size"] ??
                                                                  "",
                                                              style:
                                                                  A_style_medium1,
                                                              maxLines: 2,
                                                            ),
                                                            Text(
                                                              productlist.elementAt(
                                                                              0)[index]
                                                                          [
                                                                          "combo"][0]
                                                                      [
                                                                      "toping_quantity"] ??
                                                                  "",
                                                              style:
                                                                  A_style_medium1,
                                                              maxLines: 2,
                                                            ),
                                                            Text(
                                                              productlist.elementAt(
                                                                              0)[index]
                                                                          [
                                                                          "combo"][0]
                                                                      [
                                                                      "wing_quantity"] ??
                                                                  "",
                                                              style:
                                                                  A_style_medium1,
                                                              maxLines: 2,
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    h / 100),
                                                            Text(
                                                              "CAD ${productlist.elementAt(0)[index]["combo"][0]["combo_price"] ?? ""}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "Amazon_med"),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    h / 0200),
                                                            GestureDetector(
                                                              onTap: (){
                                                                Addproduct
                                                                    .clear();
                                                                Addproduct
                                                                    .add({
                                                                  'productId': productlist.elementAt(0)[index]["combo"][0]["_id"].toString(),
                                                                  "product_name":
                                                                  productlist.elementAt(0)[index]["combo"][0]["combo_name"] ??
                                                                      "",
                                                                  "product_price":
                                                                  productlist.elementAt(0)[index]["combo"][0]["combo_price"]??"",
                                                                  "image":
                                                                  cate.elementAt(0)[menuItemList]["category_logo"] ??
                                                                      '',
                                                                  "cart_price":productlist.elementAt(0)[index]["combo"][0]["combo_price"]??"",

                                                                });
                                                                Addtocart
                                                                    .Addtocartforcombo(Addproduct);
                                                              },
                                                              child: Container(
                                                                width: w / 2,
                                                                height: h / 20,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                20)),
                                                                child: Text(
                                                                  "Add to Order",
                                                                  style: TextBold,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    h / 100),
                                                          ],
                                                        )
                                                      ],
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
                                )
                              : productlist.elementAt(0)[0]["size_name"].isEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: w,
                                            height: h / 3,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                  fit: BoxFit.fill,
                                                  "$user_image_url${cate.elementAt(0)[menuItemList]["category_logo"]}"),
                                            )),
                                        SizedBox(
                                          height: h / 70,
                                        ),
                                        Text(
                                            cate.elementAt(0)[menuItemList]
                                                    ["category_name"] ??
                                                "",
                                            style: Text_Lit_Bold),
                                        SizedBox(
                                          height: h / 70,
                                        ),
                                        cate.elementAt(0)[menuItemList]
                                                    ["category_name"] ==
                                                "Wings"
                                            ? ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: productlist
                                                    .elementAt(0)
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                            dividerColor: Colors
                                                                .transparent),
                                                    child: ExpansionTile(
                                                        tilePadding:
                                                            EdgeInsets.all(0),
                                                        iconColor: Colors.black,
                                                        title: Text(
                                                            '${productlist.elementAt(0)[index]["product_name"]}  CAD${productlist.elementAt(0)[index]["price"]}  ',
                                                            style:
                                                                A_style_medium),
                                                        expandedCrossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            productlist
                                                                    .elementAt(
                                                                        0)[0]
                                                                ["description"],
                                                          ),
                                                          SizedBox(
                                                            height: h / 90,
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
                                                                        .black,
                                                                    width: 1)),
                                                            child:
                                                                DropdownButton(
                                                              underline:
                                                                  const SizedBox(),
                                                              // Initial Value
                                                              value:
                                                                  dropdownvalue,
                                                              hint: Text(
                                                                  'select'),
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
                                                                      items),
                                                                );
                                                              }).toList(),

                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownvalue =
                                                                      newValue ??
                                                                          "";
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: h / 80,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Addproduct
                                                                  .clear();
                                                              Addproduct.add({
                                                                'productId': productlist
                                                                    .elementAt(0)[
                                                                        index]
                                                                        ["_id"]
                                                                    .toString(),
                                                                "product_name":
                                                                    productlist.elementAt(0)[index]
                                                                            [
                                                                            "product_name"] ??
                                                                        "",
                                                                "product_price":
                                                                    productlist.elementAt(0)[index]
                                                                            [
                                                                            "price"] ??
                                                                        "",
                                                                "flavour":dropdownvalue ?? "",
                                                                "image":
                                                                cate.elementAt(0)[menuItemList]["category_logo"] ??
                                                                    '',
                                                                "cart_price":  productlist.elementAt(0)[index]["price"].toString() ?? "",
                                                              });
                                                              Addtocart
                                                                  .Addtocartforwings(
                                                                      Addproduct);
                                                              //Get.to(() => const YourOrder());
                                                            },
                                                            child: Container(
                                                              width: w,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Text(
                                                                "Add to Order",
                                                                style: TextBold,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          )
                                                        ]),
                                                  );
                                                },
                                              )
                                            : productlist
                                                    .elementAt(0)[0]
                                                        ["wings_drinks"]
                                                    .isEmpty
                                                ? ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: productlist
                                                        .elementAt(0)
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                                dividerColor: Colors
                                                                    .transparent),
                                                        child: ExpansionTile(
                                                            tilePadding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            iconColor:
                                                                Colors.black,
                                                            title: Text(
                                                                '${productlist.elementAt(0)[index]["product_name"]}  CAD${productlist.elementAt(0)[index]["price"]} ',
                                                                style:
                                                                    A_style_medium),
                                                            expandedCrossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                productlist.elementAt(
                                                                            0)[0]
                                                                        [
                                                                        "description"] ??
                                                                    "",
                                                              ),
                                                              SizedBox(
                                                                height: h / 90,
                                                              ),

                                                              InkWell(
                                                                onTap: () {
                                                                  cart_price = int.parse(
                                                                      productlist
                                                                              .elementAt(0)[index]
                                                                          [
                                                                          "price"]);
                                                                  print(
                                                                      cart_price);
                                                                  var pppp =
                                                                      cart_price *
                                                                          1;
                                                                  Addproduct
                                                                      .clear();
                                                                  Addproduct.add({
                                                                    'productId': productlist
                                                                        .elementAt(0)[
                                                                            index]
                                                                            [
                                                                            "_id"]
                                                                        .toString(),
                                                                    "product_name":
                                                                        productlist.elementAt(0)[index]["product_name"] ??
                                                                            "",
                                                                    "order_quantity":
                                                                        1,
                                                                    "product_price":
                                                                        productlist.elementAt(0)[index]["price"] ??
                                                                            "",
                                                                    "image":
                                                                        cate.elementAt(0)[menuItemList]["category_logo"] ??
                                                                            '',
                                                                    "cart_price":
                                                                        pppp ??
                                                                            "",
                                                                  }
                                                                      //beverages_quantity:req.body.beverages_quantity,
                                                                      //             beverages_price:req.body.beverages_price,
                                                                      );
                                                                  Addtocart
                                                                      .Addtocartfordessert(
                                                                          Addproduct);

                                                                  //Get.to(() => const YourOrder());
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: w,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  child: Text(
                                                                    "Add to Order",
                                                                    style:
                                                                        TextBold,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                      );
                                                    },
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: productlist
                                                        .elementAt(0)
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                                dividerColor: Colors
                                                                    .transparent),
                                                        child: ExpansionTile(
                                                            tilePadding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            iconColor:
                                                                Colors.black,
                                                            title: Text(
                                                                '${productlist.elementAt(0)[index]["product_name"]}  ',
                                                                style:
                                                                    A_style_medium),
                                                            expandedCrossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                productlist
                                                                        .elementAt(
                                                                            0)[0]
                                                                    [
                                                                    "description"],
                                                              ),
                                                              SizedBox(
                                                                height: h / 90,
                                                              ),
                                                              ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount: productlist
                                                                    .elementAt(0)[
                                                                        0][
                                                                        "wings_drinks"]
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index1) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: GetBuilder<
                                                                            PizzaController>(
                                                                        builder:
                                                                            (PizzaController
                                                                                controller) {
                                                                      return Row(
                                                                        children: [
                                                                          SizedBox(
                                                                              width:
                                                                                  w / 30),
                                                                          SizedBox(
                                                                              width: w /
                                                                                  3,
                                                                              child:
                                                                                  Text("${productlist.elementAt(0)[index]["wings_drinks"][index1]["quantitiy"]} - CAD${productlist.elementAt(0)[index]["wings_drinks"][index1]["price"]} ")),
                                                                          InkWell(
                                                                            onTap: () {
                                                                              Addproduct
                                                                                  .clear();
                                                                              Addproduct
                                                                                  .add({
                                                                                'productId': productlist
                                                                                    .elementAt(0)[
                                                                                index]
                                                                                [
                                                                                "_id"]
                                                                                    .toString(),
                                                                                "product_name":
                                                                                productlist.elementAt(0)[index]["product_name"] ??
                                                                                    "",
                                                                                "beverages_quantity":
                                                                                productlist.elementAt(0)[index]["wings_drinks"][index1]["quantitiy"]??"",
                                                                                "beverages_price":
                                                                                productlist.elementAt(0)[index]["wings_drinks"][index1]["price"]??"",
                                                                                "image":
                                                                                cate.elementAt(0)[menuItemList]["category_logo"] ??
                                                                                    '',
                                                                                "cart_price":productlist.elementAt(0)[index]["wings_drinks"][index1]["price"]??"",
                                                                              });
                                                                              Addtocart
                                                                                  .Addtocartforberverage(
                                                                                  Addproduct);
                                                                              //Get.to(() => const YourOrder());
                                                                            },
                                                                            child:
                                                                            Container(
                                                                              width: w/2,height: h/20,
                                                                              padding:
                                                                              EdgeInsets
                                                                                  .all(
                                                                                  10),
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors
                                                                                      .black,
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      20)),
                                                                              child: Text(
                                                                                "Add to Order",
                                                                                style:
                                                                                TextBold,
                                                                                textAlign:
                                                                                TextAlign
                                                                                    .center,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }),
                                                                  );
                                                                },
                                                              ),
                                                              // SizedBox(
                                                              //   height: h / 80,
                                                              // ),
                                                              // InkWell(
                                                              //   onTap: () {
                                                              //     Addproduct
                                                              //         .clear();
                                                              //     Addproduct
                                                              //         .add({
                                                              //       'productId': productlist
                                                              //           .elementAt(0)[
                                                              //               index]
                                                              //               [
                                                              //               "_id"]
                                                              //           .toString(),
                                                              //       "product_name":
                                                              //           productlist.elementAt(0)[index]["product_name"] ??
                                                              //               "",
                                                              //       "order_quantity":
                                                              //           controller
                                                              //               .counter,
                                                              //       "product_price":
                                                              //           productlist.elementAt(0)[index]["price"] ??
                                                              //               "",
                                                              //       "beverages_quantity":
                                                              //           "",
                                                              //       "beverages_price":
                                                              //           "",
                                                              //     });
                                                              //     Addtocart
                                                              //         .Addtocartforwings(
                                                              //             Addproduct);
                                                              //     //Get.to(() => const YourOrder());
                                                              //   },
                                                              //   child:
                                                              //       Container(
                                                              //     width: w,
                                                              //     padding:
                                                              //         EdgeInsets
                                                              //             .all(
                                                              //                 8),
                                                              //     decoration: BoxDecoration(
                                                              //         color: Colors
                                                              //             .black,
                                                              //         borderRadius:
                                                              //             BorderRadius.circular(
                                                              //                 20)),
                                                              //     child: Text(
                                                              //       "Add to Order",
                                                              //       style:
                                                              //           TextBold,
                                                              //       textAlign:
                                                              //           TextAlign
                                                              //               .center,
                                                              //     ),
                                                              //   ),
                                                              // )
                                                            ]),
                                                      );
                                                    },
                                                  )
                                      ],
                                    )
                                  :
                      /*PIZZA*/
                      ListView.builder(
                                      itemCount:
                                          productlist.elementAt(0).length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(() => OrderDetails(
                                                  index: index,
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              Stack(children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(3),
                                                  width: w / 1.043,
                                                  height: h / 4.5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "$user_image_url${productlist.elementAt(0)[index]["product_image"]}",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Container(
                                                    width: w / 1.043,
                                                    margin:
                                                        const EdgeInsets.all(3),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            // Color(0xff08080863),
                                                            // Color(0xff080808)
                                                            Color(0xff08080863),
                                                            Colors.black,
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8),
                                                              bottomLeft: Radius
                                                                  .circular(8)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: h / 30,
                                                        ),
                                                        Text(
                                                          productlist.elementAt(
                                                                      0)[index][
                                                                  "product_name"] ??
                                                              "",
                                                          style: TextBold,
                                                        ),
                                                        Text(
                                                          productlist.elementAt(
                                                                      0)[index][
                                                                  "description"] ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  //letterSpacing: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Colors
                                                                      .white,

                                                                  //  fontFamily: "Amazon_med",
                                                                  fontSize: 14),
                                                          maxLines: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            // Text(
                                                            //   "CAD 49",
                                                            //   style: TextBold,
                                                            // ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Text(
                                                                "Order Now",
                                                                style:
                                                                    Text_inside_button,
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
                    },
                  )
          ],
        ),
      ),
    );
  }
}
