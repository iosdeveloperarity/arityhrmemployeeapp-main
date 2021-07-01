import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/apiinterface/ApiInterface.dart';
import 'package:hrm_app/bloc/switchwidget.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  var height;
  var width;
  String clocktime='';
  DateTime _currentDate = DateTime.now();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String employeeid;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  SharedPreferences sharedPreferences;
  String getTimeStrored="";
  DateTime storeCurrentTime;
  bool changeInOUTButtons=false;
  String current_punch="";
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    employeeid="4064ad14-6e50-41f3-9eef-ff667707ec7c";
  }

  init() async {
    sharedPreferences=await SharedPreferences.getInstance();
    changeInOUTButtons=sharedPreferences.getBool("time");
    print(changeInOUTButtons);
    if(changeInOUTButtons==null){
      changeInOUTButtons=false;
      current_punch="punchin";
    }
    else{
      if(changeInOUTButtons==false){
        current_punch="punchin";
      }
      else{
        current_punch="punchout";
      }
    }
    setState(() {});
    print(current_punch);
  }


  @override
  Widget build(BuildContext context) {
    height= MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text("Attendance",style: TextStyle(fontFamily: 'Roboto',fontSize: 16,color: Colors.white),),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,)),
        backgroundColor: Constant.hexStringToColor("#00BDFF"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: SvgPicture.asset(ImageAssets.notification,color: Colors.white,)),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: (){
                  _scaffoldKey.currentState.openDrawer();
                },
                child: SvgPicture.asset(ImageAssets.menu,color: Colors.white,)),
          ),
        ],
      ),
      drawer: Drawer(
          child: DrawerWidget()
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                // height: height,
                // width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 248,
                      width: 375,
                      color: Constant.hexStringToColor('#00BDFF'),
                      child:Center(
                        child: Text("Attendance Check",style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            color: Colors.white
                        ),),
                      ),
                    ),
                    InkWell(
                      onTap: (){


                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap:(){
                               setState(() {
                                 print(Constant.changeINOUTButtons);
                                _authorize("IN");
                               });
                              },
                              child: Container(
                                height: 49,
                                width: 157,
                                margin: EdgeInsets.only(top: 260,right: 4,left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: current_punch=="punchin"?Constant.hexStringToColor('#37C12F'):Colors.grey[300],
                                ),
                                child: Center(
                                  child: Text("CLOCK IN",style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Colors.white
                                  ),),
                                ),
                              ),
                            ),
                            SizedBox(width: 2,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _authorize("OUT");
                                });
                              },
                              child: Container(
                                height: 49,
                                width: 157,
                                margin: EdgeInsets.only(top: 260,right: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color:current_punch=="punchout"?Constant.hexStringToColor('#00BDFF'):Colors.grey[300],
                                ),
                                child: Center(
                                  child: Text("CLOCK OUT",style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      color: Colors.white
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 320,
                // width: 320,
                margin: EdgeInsets.only(top: 177,right: 20,left: 20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(

                  children: [
                    CalendarCarousel<Event>(
                      onDayPressed: (DateTime date, List<Event> events) {
                        this.setState(() => _currentDate = date);
                        print(date);
                      },

                      thisMonthDayBorderColor: Colors.grey,
                      customDayBuilder: (
                          bool isSelectable,
                          int index,
                          bool isSelectedDay,
                          bool isToday,
                          bool isPrevMonthDay,
                          TextStyle textStyle,
                          bool isNextMonthDay,
                          bool isThisMonthDay,
                          DateTime day,
                          ) {
                      },
                      weekFormat: false,

                      height: 295,
                      childAspectRatio: 1.4,
                      iconColor: Colors.black,
                      weekDayFormat: WeekdayFormat.narrow,
                      weekdayTextStyle: TextStyle(fontSize: 15,color: Constant.hexStringToColor('#B9B9B9'),fontFamily: 'Roboto'),
                      headerTextStyle: TextStyle(fontFamily: 'Roboto',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
                      headerMargin: EdgeInsets.only(left: 50,right: 50),
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      isScrollable: false,
                      selectedDateTime: _currentDate,
                      selectedDayButtonColor: Colors.blue,
                      daysHaveCircularBorder: null, /// null for not rendering any border, true for circular border, false for rectangular border
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle
                                ),

                              ),
                              SizedBox(width: 5,),
                              Text("Present",style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  color: Constant.hexStringToColor('#4B4E56')
                              ),),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle
                                ),

                              ),
                              SizedBox(width: 5,),
                              Text("Absent",style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  color: Constant.hexStringToColor('#4B4E56')
                              ),),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getPunchInOut(String employeeID,String attendancedate,String punchmethod, String enrollno,String punchtype){
    print("Enter");
    ApiInterface().puchINOUT("", "", "", employeeID, attendancedate, punchmethod, enrollno).then((value){
      if(value!=null){
        if(value.isSuccess){
          Fluttertoast.showToast(msg: "Successfully "+punchtype);
        }
      }
    });
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
        if(changeInOUTButtons==false){
          clocktime="IN";
          if( formatter.format(_currentDate)==formatter.format(DateTime.now())){
            Constant.punchmethod="IN = 1";
            Constant.manualIn=DateFormat.Hm().format(DateTime.now());
            var current_time=DateFormat.Hm().format(DateTime.now());
            print(current_time);
            String attendancedate=formatter.format(DateTime.now()).toString() +" "+current_time.toString();
            // Constant.changeINOUTButtons=true;
            changeInOUTButtons=true;
            getPunchInOut(employeeid, attendancedate, Constant.punchmethod, "1", "PUNCH IN");
            sharedPreferences.setBool("time",true);
            current_punch="punchout";
          }
          else{
            Fluttertoast.showToast(msg: "Please select current date");
          }
        }
      }
      else if(_isAuthorized && punchtype=="OUT") {
        if(changeInOUTButtons==true){
          clocktime="OUT";
          Constant.punchmethod="OUT = 1";
          if(formatter.format(_currentDate)==formatter.format(DateTime.now())){
            var current_time=DateFormat.Hm().format(DateTime.now());
            Constant.manualOut=DateFormat.Hm().format(DateTime.now());
            print(current_time);
            String attendancedate=formatter.format(DateTime.now()).toString() +" "+current_time.toString();
            getPunchInOut(employeeid, attendancedate, Constant.punchmethod, "1", "PUNCH OUT");
            changeInOUTButtons=false;
            sharedPreferences.setBool("time",false);
            current_punch="punchin";
          }
          else{
            Fluttertoast.showToast(msg: "Please select current date");
          }
        }
      }
      else {
        Fluttertoast.showToast(
            msg: "Authentication Failed");
      }
    }
    );
  }
}
