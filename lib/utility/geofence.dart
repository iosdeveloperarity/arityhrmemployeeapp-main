import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart'as geo;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:network_info_plus/network_info_plus.dart';

class Geofence extends StatefulWidget {
  @override
  GeofenceState createState() => GeofenceState();
}

class GeofenceState extends State<Geofence> {

  static const baseUrl = "https://api.radar.io/v1/";
  final Dio _dio = Dio();
  String device_Id;
  int user_id=1;
  Future<geo.Position> position;
  String lat,lang;
  String user_event;
  String wifiName, wifiBSSID, wifiIP;
  final NetworkInfo _networkInfo = NetworkInfo();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isavailable;
  String connectionStatus = 'Unknown';
  String choosen_latlong="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceDetails();
    initNetworkInfo();
    initConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Column(
                  //   children: [
                  //     Text("22.289356, 70.787338"),
                  //     SizedBox(height: 10,),
                  //     InkWell(
                  //       onTap: (){
                  //         getDeviceDetails();
                  //         choosen_latlong="Arity";
                  //         _initNetworkInfo();
                  //         getPosition();
                  //         },
                  //       child: Container(
                  //         height: 70,
                  //         width: 180,
                  //         padding: EdgeInsets.all(5.0),
                  //         margin: EdgeInsets.all(8.0),
                  //         decoration: BoxDecoration(
                  //           color: Colors.blue,
                  //           borderRadius: BorderRadius.circular(8.0)
                  //         ),
                  //         child: Center(child: Text("Click to use above latitude and longitude to enter Arity Infoway's geofence",style: TextStyle(color: Colors.white),),),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Column(
                    children: [
                      Text("Check Your Geofence"),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          getGeoPosition();
                        },
                        child: Container(
                          height: 70,
                          width: 180,
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Center(child: Text("Click me",style: TextStyle(color: Colors.white),),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          )
      ),
    );
  }

  Future<void> createGeofence() async {
    String url = baseUrl + "geofences/venue/2";
    Map data ={
      "description": "Arity Infoway",
      "type": "circle",
      "coordinates": "[22.285641245138915,70.75633641762559]",
      "radius": "15"
    };
    var body=json.encode(data);
    try {
      Response response = await _dio.put(url, data: body,options: Options(

          headers: {'Content-Type': 'application/json','Authorization': Constant.live_secret_key}
      ));
      if (response.statusCode == 200) {
        print("Enter");

        print("Response : " + response.toString());

        if(lat!=null && lang!=null){
          createUser();
        }
      } else{

      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<void> createUser() async {
    print(lat);
    print(lang);
    print(user_id);
    print(device_Id);
    String url = baseUrl + "track";
    Map data ={
      "userId": user_id.toString(),
      "latitude":lang,
      "longitude":lat,
      "accuracy":"20",
      "deviceId": device_Id
    };
    var body=json.encode(data);
    try {
      Response response = await _dio.post(url, data: body,options: Options(

          headers: {'Content-Type': 'application/json','Authorization': Constant.live_secret_key}
      ));
      if (response.statusCode == 200) {
        print("Enter");
        print("Response : " + response.toString());
        // print(response.data['events'][0]['type']);
        if(response.data['events'].isNotEmpty){
          user_event=response.data['events'][0]['type'];
          if(user_event=="user.entered_geofence")
          {
            initConnectivity();
            Fluttertoast.showToast(msg: "You have Entered Arity's Geofence");

          }
          else{
            Fluttertoast.showToast(msg: "You will not able to sign in you are out of geofence");
          }
        }
        else{
          initConnectivity();
        }

      } else{

      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
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

  getGeoPosition() async {
    print("enter");
    geo.Position position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    print(position);
    lang=position.longitude.toString();
    lat=position.latitude.toString();
    print(lat);
    print(lang);
    if(lat!=null){
      createGeofence();
    }
  }

  Future<void> initNetworkInfo() async {

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
          print(wifiName);
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      print(e.toString());
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();

        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      print(e.toString());
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIP = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      print(e.toString());
      wifiIP = 'Failed to get Wifi IP';
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
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    print(wifiName);
    print(_connectionStatus);
    if(_connectionStatus==ConnectivityResult.wifi){
      if(wifiName=="DESKTOP-2EAS0E1 6768"){
        isavailable=true;
        Fluttertoast.showToast(msg: "You have successfully logged in");
      }
      else{
        isavailable=false;
        print("enter");
        Fluttertoast.showToast(msg: "You are not allowed to sign in with other network");
      }
      connectionStatus = 'Wifi Name: $wifiName\n'
          'Wifi BSSID: $wifiBSSID\n';
    }
    else{
      Fluttertoast.showToast(msg: "You are not allowed to sign in with other network");
    }
  }

}

