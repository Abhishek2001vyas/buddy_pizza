import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../api/terms&condition_api.dart';
import '../../../../theme/color.dart';

class TermsCondition extends StatelessWidget {
  // const TermsCondition({super.key});

  final termsapi = Get.put(termscondition_api());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          "Term & Condition",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: termsapi.terms_condition(),
              builder: (context, snapshot) {
                return terms_condition_list.isEmpty
                    ? Center(child: Text("No Data"))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            terms_condition_list
                                .elementAt(0)["title"]
                                .toString(),
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            terms_condition_list
                                .elementAt(0)["description"]
                                .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                letterSpacing: 1,
                                fontFamily: "Roboto_thin"),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
