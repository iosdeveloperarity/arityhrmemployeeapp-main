import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_app/page/attendancepage.dart';
import 'package:hrm_app/page/dashboard.dart';
import 'package:hrm_app/page/profile.dart';
import 'package:hrm_app/page/salaryslip.dart';
import 'package:hrm_app/page/save_leave_application.dart';
import 'package:hrm_app/page/splashscreen.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/utility/firebase_push_notification.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart'as geo;
import 'package:workmanager/workmanager.dart';

String wifiName, wifiBSSID, wifiIP;
final NetworkInfo _networkInfo = NetworkInfo();
ConnectivityResult _connectionStatus = ConnectivityResult.none;
final Connectivity _connectivity = Connectivity();
StreamSubscription<ConnectivityResult> _connectivitySubscription;
bool isavailable;
String device_Id;
String lat,lang;
SharedPreferences sharedPreferences;
Position position;


void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void isolate2(String arg) {
  Timer.periodic(
      Duration(seconds: 1), (timer) {
        getDeviceDetails();
        initConnectivity();

  });
}

void isolate1(String arg) async {
  /*final isolate =*/ await FlutterIsolate.spawn(isolate2, "hello2");
  Timer.periodic(
      Duration(seconds: 1), (timer) {});
}

Future<void> main() async {
  _enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  _getUserLocation();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<void> _run() async {
    final isolate = await FlutterIsolate.spawn(isolate1, "hello");
    // Timer(Duration(seconds: 5), () {
    //   print("Pausing Isolate 1");
    //   isolate.pause();
    // });
    // Timer(Duration(seconds: 10), () {
    //   print("Resuming Isolate 1");
    //   isolate.resume();
    // });
    // Timer(Duration(seconds: 20), () {
    //   print("Killing Isolate 1");
    //   isolate.kill();
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _run();
  }

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
    Future.delayed(Duration(seconds: 4), () {
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
    print(stringValue);
    if (stringValue != null) {
      Constant.employee_id = stringValue;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SplashScreen()),
      );
    }
  }

}

Future<void> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        device_Id = build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String wifiName;
    _connectionStatus=result;
    print(_connectionStatus);
    wifiName = await _networkInfo.getWifiName();
    if(_connectionStatus==ConnectivityResult.wifi){
        print("Enter wifi");
        print(wifiName);
        if(wifiName=="DESKTOP-2EAS0E1 6768"){

        }
        else{
          prefs.remove("lastButtonPress");
        }
      }
      else{
      prefs.remove("lastButtonPress");
        print("Enter nothing");
      }
  }

  void _getUserLocation() async {
  position = await
  Geolocator.getCurrentPosition(forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.lowest);
  }



















