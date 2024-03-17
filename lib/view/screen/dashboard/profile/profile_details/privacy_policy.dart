import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../api/terms&condition_api.dart';

class PrivacyPolicy extends StatelessWidget {
  //const PrivacyPolicy({super.key});

  final termsapi = Get.put(termscondition_api());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          "Privacy Policy",
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: termsapi.privacy_policy(),
            builder: (context, snapshot) {
              return privacy_policy_list.isEmpty
                  ? Center(child: Text("No Data"))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          privacy_policy_list.elementAt(0)["title"].toString(),
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          privacy_policy_list
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
          )),
    );
  }
}
