import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_app/apiinterface/ApiInterface.dart';
import 'package:hrm_app/bloc/switchtimewidget.dart';
import 'package:hrm_app/page/attendancepage.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var height;
  var width;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var counter = 0;
  String latitiude, longitude,location,employeeid,attendancedate,enrollno="1";
  DateTime _lastButtonPress;
  String _pressDuration;
  Timer _ticker;
  SharedPreferences sharedPreferences;
  var lastPressString;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    employeeid="4064ad14-6e50-41f3-9eef-ff667707ec7c";
    Constant.appbarTitle = "Clock in time";
    print("true");
    _getUserLocation();

  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(Constant.appbarTitle, style: TextStyle(
          fontFamily: 'Roboto', fontSize: 16, color: Colors.black,),),
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black,)),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: SvgPicture.asset(ImageAssets.notification)),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                child: SvgPicture.asset(ImageAssets.menu)),
          ),
        ],
      ),
      drawer: Drawer(
          child: DrawerWidget()
      ),
      body: Stack(
        children: [
          _initialPosition == null ? Container
            (
            child:
            Center
              (child:
            Text('loading map..', style: TextStyle(fontFamily: 'Roboto',
                color: Colors.grey[400],
                fontWeight: FontWeight.w500),),),) :
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,

            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
          ),
          Form(
                key: _formKey,
                child: Container(
                  height: height,
                  width: width,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage(ImageAssets.map),
                  //         fit: BoxFit.cover
                  //     )
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      lastPressString!=null ?
                      Container(
                          height: 176,
                          width: 315,
                          margin: EdgeInsets.only(
                              left: 25, right: 25, bottom: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular((10.0))
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextFormField(controller: Constant.date2,
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                          hintText: 'date',
                                          enabled: false,
                                          // contentPadding: EdgeInsets.only(bottom: 25),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constant
                                                    .hexStringToColor(
                                                    '#00BDFF')),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextFormField(
                                        controller: Constant.time2,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: 'time',
                                          // contentPadding: EdgeInsets.only(bottom: 15),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constant
                                                    .hexStringToColor(
                                                    '#00BDFF')),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 49,
                                    width: 135,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text("WORKING HOURS", style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Roboto'),),
                                        Text(_pressDuration==null?"00:00:00":_pressDuration, style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                     _authorize("OUT");
                                    },
                                    child: Container(
                                      height: 49,
                                      width: 135,
                                      margin: EdgeInsets.only(
                                          top: 10, right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                          color: Constant.hexStringToColor(
                                              "#00BDFF")
                                      ),
                                      child: Center(child: Text("PUNCH OUT",
                                        style: TextStyle(color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Roboto'),)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ) : Container(
                          height: 176,
                          width: 315,
                          margin: EdgeInsets.only(
                              left: 25, right: 25, bottom: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular((10.0))
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            controller: Constant.date,
                                            keyboardType: TextInputType
                                                .datetime,
                                            decoration: InputDecoration(
                                              hintText: 'Date',
                                              // contentPadding: EdgeInsets.only(bottom: 25),
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Roboto'),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constant
                                                        .hexStringToColor(
                                                        '#00BDFF')),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextFormField(
                                        controller: Constant.time,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: 'Time',
                                          // contentPadding: EdgeInsets.only(bottom: 15),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Roboto'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constant
                                                    .hexStringToColor(
                                                    '#00BDFF')),
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                if (Constant.date.text != "" &&
                                  Constant.time.text != "") {
                                  _authorize("IN");
                                }
                                else{
                                  Fluttertoast.showToast(msg: "Please Select Today's Date");
                                }

                                },
                                child: Container(
                                  height: 49,
                                  width: 283,
                                  margin: EdgeInsets.only(top: 20, bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Constant.hexStringToColor(
                                          "#37C12F")
                                  ),
                                  child: Center(child: Text("PUNCH IN",
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Roboto'),)),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    Constant.appbarTitle = 'Attendance';
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          AttendancePage()),
                                    );
                                  },
                                  child: Text("Skip", style: TextStyle(
                                      color: Constant.hexStringToColor(
                                          '#4B4E56'),
                                      fontSize: 12,
                                      fontFamily: 'Roboto'),))

                            ],
                          )
                      )
                    ],
                  ),
                ),

          ),
        ],
      ),
    );
  }
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState((){
      _initialPosition = LatLng(position.latitude, position.longitude);
      latitiude=position.latitude.toString();
      longitude=position.longitude.toString();

      _lastMapPosition=_initialPosition;
      _onAddMarkerAdd();
    });
    final coordinates = new Coordinates(
        position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    location=first.addressLine;
    print(location);
  }

  _onAddMarkerAdd() {
    setState(() {
      _markers.add(
          Marker(
              markerId: MarkerId(_lastMapPosition.toString()),
              position: _lastMapPosition,
              icon: BitmapDescriptor.defaultMarker));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }




  Future<Null> _selectDate(BuildContext context) async {
    var one,two;
    final DateTime picked = await showDatePicker(
        context: context,

        initialDate: Constant.selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null)
      setState(() {
        print(picked);
        Constant.selectedDate = picked;
        String formatted=formatter.format(Constant.selectedDate);
        print("formatted"+formatted.toString());
        if(formatted==formatter.format(DateTime.now())){
          if(Constant.istimerstarted==true){
            Constant.istimerstarted=false;
            Constant.date.value = TextEditingValue(text: formatted.toString());
            Constant.time.text=(DateFormat.jm().format(DateTime.now()));
            Constant.date2.value = TextEditingValue(text: formatted.toString());
            Constant.time2.text=(DateFormat.jm().format(DateTime.now()));
            attendancedate=Constant.date.text+" "+DateFormat.Hm().format(DateTime.now());
            print(attendancedate);
          }
          else{
            Constant.istimerstarted=true;
            Constant.date2.value = TextEditingValue(text: formatted.toString());
            Constant.time2.text=(DateFormat.jm().format(DateTime.now()));
            attendancedate=Constant.date2.text+" "+Constant.time2.text;
          }
        }

      });

  }

  void getPunchInOut(String longitude, String latitude, String locationname, String employeeID,String attendancedate,String punchmethod, String enrollno,String punchtype){
    print("Enter");
    ApiInterface().puchINOUT(longitude, latitude, locationname, employeeID, attendancedate, punchmethod, enrollno).then((value){
      if(value!=null){
        if(value.isSuccess){
          Fluttertoast.showToast(msg: "Successfully"+punchtype);
        }
      }
    });
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    lastPressString = sharedPreferences.getString("lastButtonPress");
    if(lastPressString!=null){
      Constant.changePuch=true;
    }
    print("Last Stored Value"+lastPressString);
    print(DateTime.now());
    _lastButtonPress = lastPressString!=null ? DateTime.parse(lastPressString) : DateTime.now();
    print("Last time after parsing"+_lastButtonPress.toString());
    _updateTimer();
    _ticker = Timer.periodic(Duration(seconds:1),(_)=>_updateTimer());

  }

  void _updateTimer() {
    final duration = DateTime.now().difference(_lastButtonPress);
    final newDuration = _formatDuration(duration);
    if(mounted){
      setState(() {
        _pressDuration = newDuration;
      });
    }

  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> _authorize(String punchtype) async {
    bool _isAuthorized = false;
    try {
      _isAuthorized = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to Complete this process',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      if (_isAuthorized && punchtype=="IN") {
          Constant.time.clear();
          Constant.date.clear();
          Constant.punchmethod="IN = 1";
          Constant.manualIn=DateTime.now();
          init();
          getPunchInOut(longitude, latitiude, location, employeeid, attendancedate, Constant.punchmethod, enrollno, "Punch In");
          setState(() {
            Constant.changePuch=true;
            Constant.appbarTitle = "Clock In Time";
          });
          _lastButtonPress = DateTime.now();
          print("current_time"+_lastButtonPress.toString());
          sharedPreferences.setString("lastButtonPress",_lastButtonPress.toString());
        }
        else if(_isAuthorized && punchtype=="OUT"){
        Constant.date2.clear();
        Constant.time2.clear();
        Constant.changePuch=false;
        sharedPreferences.clear();
        setState(() {
          Constant.appbarTitle = "Clock Out Time";
        });
        Constant.punchmethod="OUT = 1";
        Constant.manualOut=DateTime.now();
        _ticker.cancel();
        getPunchInOut(longitude, latitiude, location, employeeid, attendancedate, Constant.punchmethod, enrollno, "Punch Out");
      }
        else {
          Fluttertoast.showToast(
              msg: "Authentication Failed");
        }
      }
    );
  }







}
