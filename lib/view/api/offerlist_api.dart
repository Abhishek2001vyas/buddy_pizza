import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';


class offerlist_api extends GetxController{
  RxList offerlistt = [].obs;

   offerlisttt ()async{
     print('pppppppppp');
    try {
      var res = await http.get(Uri.parse("${base_url}offerList"),);
      var resData = json.decode(res.body);
      print('pppppppppp1 ${resData}');
      if (res.statusCode == 400 &&
          resData["result"].toString() == "false".toString()) {
        print("qwert"+resData.toString());
        offerlistt.clear();
        offerlistt.add(resData["data"]);
        print("fffqwe $offerlistt");
        return offerlistt;
      } else {
        print("kidhihoiklijlk");
      }
    } catch (e) {}
  }


}