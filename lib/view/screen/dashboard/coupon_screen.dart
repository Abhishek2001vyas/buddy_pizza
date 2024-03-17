import 'package:buddy_pizza/view/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/offerlist_api.dart';
import '../../theme/color.dart';
import '../../theme/text2.dart';
import '../coupon_details.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {

  final offerlistapi = Get.put(offerlist_api());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          "Coupon",
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Get Your Coupon Now",
              style: A_style_text_head2,
            ),

            SizedBox(
              height: h / 80,
            ),

                FutureBuilder(future: offerlistapi.offerlisttt(),

                  builder: (context, snapshot) {
                    print("snap"+snapshot.data!.runtimeType.toString());
                    return ListView.builder(
                      itemCount: offerlistapi!.offerlistt[0].length,shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return    InkWell(
                          onTap: () {
                            Get.to(() => CouponDetails(index: index,));
                          },
                          child: Container(
                            width: w / 1.2,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3, color: Colors.grey.shade300)
                                ]),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      "${user_image_url}${offerlistapi!.offerlistt[0][index]["image"]}",
                                      fit: BoxFit.cover,
                                      width: w,
                                      height: h / 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: h / 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${offerlistapi!.offerlistt[0][index]["title"]}   ${offerlistapi!.offerlistt[0][index]["off_percantage"]}% off",
                                              style: Text_Lit_Bold,
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.green.shade700,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Code: ${offerlistapi!.offerlistt[0][index]["coupon_code"]}",
                                          style: Text_Lit_Bold,
                                        ),
                                        Text(
                                          "Valid: ${offerlistapi!.offerlistt[0][index]["valid_date"].toString().substring(0,10)}",
                                          style: A_style_order,
                                        ),
                                        SizedBox(
                                          height: h / 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      },);
                  },)




                // ListView.builder(
                // itemCount: 4,
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                // itemBuilder: (BuildContext context, int index) {
                //   return
                //
                // })
          ])),
    );
  }
}
