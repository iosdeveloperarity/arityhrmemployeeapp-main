import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var height;
  var width;
  String clocktime='';
  DateTime _currentDate = DateTime.now();
  DateTime manualin,manualout;
  var diffone, difftwo;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;
  String in_stored,out_stored;
  bool getTimekey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    if(getTimekey!=null){
      if(Constant.manualIn!=null){
        manualin = new DateFormat.Hm().parse(Constant.manualIn);
        manualout = new DateFormat.Hm().parse(Constant.manualOut);
        diffone = manualout.difference(manualin).inHours;
        difftwo = manualout.difference(manualin).inMinutes;
        print(diffone);
        print(difftwo);
      }
      else{
        Constant.manualIn="00:00";
        Constant.manualOut="00:00";
      }
    }


  }

  init() async {
    sharedPreferences=await SharedPreferences.getInstance();
    getTimekey=sharedPreferences.getBool("time");
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                            ),
                            Text("Employee",style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),

                    Center(
                      child: Container(
                        height: 307,
                        width: 308,
                        margin: EdgeInsets.only(top: 240),
                        child:  CircularPercentIndicator(
                          radius: 230.0,

                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 20.0,
                          percent: 0.3,

                          center: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(Constant.manualIn==null?"00:00":Constant.manualIn,style: TextStyle(fontFamily: 'Roboto',fontSize: 24,fontWeight: FontWeight.w500,color: Constant.hexStringToColor('#090D17')),),
                                      Text("Start Time",style: TextStyle(fontFamily: 'Roboto',fontSize: 12,color: Constant.hexStringToColor('#090D17')),)
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    child: VerticalDivider(
                                      color: Constant.hexStringToColor("#CCD7E6"),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(Constant.manualOut==null?"00:00":Constant.manualOut.toString(),style: TextStyle(fontFamily: 'Roboto',fontSize: 24,fontWeight: FontWeight.w500,color: Constant.hexStringToColor('#090D17')),),
                                      Text("End Time",style: TextStyle(fontFamily: 'Roboto',fontSize: 12,color: Constant.hexStringToColor('#090D17')),)
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(diffone==null?"00:":diffone.toString()+"0:",style: TextStyle(fontFamily: 'Roboto',fontSize: 36,fontWeight: FontWeight.w500,color: Constant.hexStringToColor('#090D17')),),
                                      Text(difftwo==null?"00":difftwo.toString(),style: TextStyle(fontFamily: 'Roboto',fontSize: 36,fontWeight: FontWeight.w500,color: Constant.hexStringToColor('#090D17')),),
                                    ],
                                  )),
                              Text("Total Hours",style: TextStyle(fontFamily: 'Roboto',fontSize: 12,color: Constant.hexStringToColor('#090D17')),)
                            ],
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          widgetIndicator: Image.asset(ImageAssets.bluecircle,color: Colors.indigo,),
                          backgroundColor: Constant.hexStringToColor('#CCD7E6'),
                          progressColor: Constant.hexStringToColor('#00BDFF'),
                        ),
                      ),
                    ),
                    Container(
                      height: 49,
                      width: 328,
                      margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Constant.hexStringToColor("#37C12F")
                      ),
                      child: Center(child: Text("Login As A Daily Attendance",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto'),)),
                    ),

                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 320,

                margin: EdgeInsets.only(top: 157,left: 20,right: 20),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  children: [
                    CalendarCarousel<Event>(
                      onDayPressed: (DateTime date, List<Event> events) {
                        this.setState(() => _currentDate = date);
                      },
                      weekendTextStyle: TextStyle(
                        color: Colors.red,
                      ),
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
                      selectedDayButtonColor: Colors.red,
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
}
