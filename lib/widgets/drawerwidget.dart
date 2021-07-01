import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/page/attendancepage.dart';
import 'package:hrm_app/page/calendarpage.dart';
import 'package:hrm_app/page/homepage.dart';


import 'package:hrm_app/page/leavedetails.dart';
import 'package:hrm_app/page/profile.dart';
import 'package:hrm_app/page/salarypage.dart';
import 'package:hrm_app/page/salaryslip.dart';
import 'package:hrm_app/page/settingpage.dart';
import 'package:hrm_app/page/splashscreen.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int _selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 927,
      width: 320,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 90,
              width: 243,
              margin: EdgeInsets.only(top: 36,left: 24),
              child: Row(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Arity Infoway",style: TextStyle(fontSize: 24,fontFamily: 'Roboto',fontWeight: FontWeight.w500),),
                        Text("Software Development",style: TextStyle(fontSize: 14,fontFamily: 'Roboto',),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  _selectedindex=0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaveDetailsPage()),
                );

              },
              child: Container(
                height: 53,
                width: 320,
                margin: EdgeInsets.only(top: 24,bottom: 19),
                color: _selectedindex==0?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.newleave,height: 20,width: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Leave",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=0?Constant.hexStringToColor('#43425D'):Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  _selectedindex=1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalaryPage()),
                );

              },
              child: Container(
                height: 53,
                width: 320,
                color: _selectedindex==1?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.pay,height: 20,width: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Pay Slip",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=1?Constant.hexStringToColor('#43425D'):Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  _selectedindex=2;
                });
                Constant.appbarTitle = 'HR Policy';
              },
              child: Container(
                height: 53,
                width: 320,
                margin: EdgeInsets.only(top: 24,bottom: 19),
                color: _selectedindex==2?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.hr_policy,height: 20,width: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("HR Policy",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=2?Constant.hexStringToColor('#43425D'):Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  _selectedindex=4;
                });
                Constant.appbarTitle = 'Biometric';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                margin: EdgeInsets.only(bottom: 19),
                color: _selectedindex==4?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.biometric,height: 20,width: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Biometric",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=4?Constant.hexStringToColor('#43425D'):Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  _selectedindex=5;
                });
                Constant.appbarTitle = 'Attendance';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendancePage()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                margin: EdgeInsets.only(bottom: 19),
                color: _selectedindex==5?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.attendance,height: 20,width: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Attendance",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=5?Constant.hexStringToColor('#43425D'):Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  _selectedindex=6;
                });
                Constant.appbarTitle = 'Calendar';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingPage()),
                );
                },
              child: Container(
                height: 53,
                width: 320,
                margin: EdgeInsets.only(bottom: 19),
                color: _selectedindex==6?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.calendar,height: 20,width: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Calendar",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=6?Constant.hexStringToColor('#43425D'):Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  _selectedindex=7;
                });
                Constant.appbarTitle = 'Profile';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage()),
                );

              },
              child: Container(
                height: 53,
                width: 320,
                margin: EdgeInsets.only(bottom: 19),
                color: _selectedindex==7?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAssets.profile,height: 20,width: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Profile",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=7?Constant.hexStringToColor('#43425D'):Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  _selectedindex=8;
                });
                SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SplashScreen()),
                );

              },
              child: Container(
                height: 53,
                width: 320,
                margin: EdgeInsets.only(bottom: 19),
                color: _selectedindex==8?Constant.hexStringToColor('#37C12F'):Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new,color: Colors.red,size: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Logout",style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: _selectedindex!=8?Constant.hexStringToColor('#43425D'):Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
