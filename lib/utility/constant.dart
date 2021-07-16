import 'dart:async';

import 'package:flutter/material.dart';

class Constant{

  static String auth_token="dAbdfdXNlcm5hbW5Szc3ghdfdvcmQ=";
  static String employee_id;
  static String userid;
  static bool changePuch=false;
  static DateTime selectedDate = DateTime.now();
  static TextEditingController date = new TextEditingController();
  static TextEditingController time = new TextEditingController();
  static TextEditingController date2 = new TextEditingController();
  static TextEditingController time2 = new TextEditingController();
  static String punchmethod;
  static var manualIn;
  static var manualOut;
  static bool istimerstarted=false;
  static bool changeINOUTButtons=false;

  static hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static String appbarTitle="Attendance";

  static bool appbarvisibility=false;

  static String test_publish_key="prj_test_pk_608da7782c1e81caa94e9f9651a816900cbc74fb";
  static String live_secret_key="prj_live_sk_8457275c5860b0f9c653a8a2da27abf6c3151817";
  static String live_publish_key="prj_live_pk_33f09e854f9480519fefe7b1cd703a4e7575d323";



}

