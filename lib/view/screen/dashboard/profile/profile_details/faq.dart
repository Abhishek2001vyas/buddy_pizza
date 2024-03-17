import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';

import '../../../../theme/text2.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          "FAQ",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "This is a Privacy Policy",
              style: A_style_medium,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
                style: A_style_order),
            Divider(
              color: Colors.grey.shade500,
            ),
            const Text(
              "How the Information is collected",
              style: TextStyle(
                  fontFamily: "Ember_Display_Medium",
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Information provided by web browser",
              style: A_style_medium,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.",
                style: A_style_order),
          ],
        ),
      ),
    );
  }
}
