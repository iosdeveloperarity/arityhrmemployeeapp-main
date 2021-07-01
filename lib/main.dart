import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/page/attendancepage.dart';
import 'package:hrm_app/page/dashboard.dart';
import 'package:hrm_app/page/profile.dart';
import 'package:hrm_app/page/salaryslip.dart';
import 'package:hrm_app/page/save_leave_application.dart';
import 'package:hrm_app/page/splashscreen.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/utility/firebase_push_notification.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool session_flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pushNotificationService = PushNotificationService();
    pushNotificationService.initialise();
    Future.delayed(Duration(seconds: 4),(){
      getStringValuesSF();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Center(
          child: Image.asset(ImageAssets.splashLogo, height: 56, width: 160,),
        ),
      ),
    );
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('emp_id');
    if (stringValue != null) {
      Constant.employee_id=stringValue;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardPage()),
      );
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SplashScreen()),
      );
    }
  }
}




