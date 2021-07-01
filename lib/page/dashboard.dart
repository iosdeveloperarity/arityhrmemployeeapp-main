import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrm_app/page/attendancepage.dart';
import 'package:hrm_app/page/calendarpage.dart';
import 'package:hrm_app/page/homepage.dart';
import 'package:hrm_app/page/leavedetails.dart';
import 'package:hrm_app/page/profile.dart';
import 'package:hrm_app/page/salarypage.dart';
import 'package:hrm_app/page/settingpage.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var height;
  var width;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text("Home",style: TextStyle(fontFamily: 'Roboto',fontSize: 16,color: Colors.white),),

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
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Constant.hexStringToColor('#00BDFF'),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: width,
                  height: 140,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),

                  ),
                  child: Center(
                    child: SvgPicture.asset(ImageAssets.arity_logo,height: 50,width: 50,),
                  ),
                ),
                Container(
                  width: width,

                  margin: EdgeInsets.only(bottom: 20,top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(5.0),topLeft: Radius.circular(5.0))
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(4.0),

                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaveDetailsPage()),
                          );
                        },
                        child: Container(

                          decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: Colors.grey[300]),bottom:BorderSide(color: Colors.grey[300]) )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageAssets.newleave,height: 30,width: 30,),
                              SizedBox(height: 10,),
                              Text("Leave",style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto',
                                  color: Colors.black
                              ),),
                            ],
                          )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalaryPage()),
                          );
                        },
                        child: Container(

                            decoration: BoxDecoration(
                                border: Border(bottom:BorderSide(color: Colors.grey[300]) )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageAssets.pay,height: 30,width: 30,),
                                SizedBox(height: 10,),
                                Text("PaySlip",style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    color: Colors.black
                                ),),
                              ],
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => TestWidget()),
                          // );
                        },
                        child: Container(

                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Colors.grey[300]),bottom:BorderSide(color: Colors.grey[300]) )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageAssets.hr_policy,height: 30,width: 30,),
                                SizedBox(height: 10,),
                                Text("HR Policy",style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    color: Colors.black
                                ),),
                              ],
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()),
                          );
                        },
                        child: Container(

                            decoration: BoxDecoration(
                                border: Border(bottom:BorderSide(color: Colors.grey[300]) )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageAssets.biometric,height: 30,width: 30,),
                                SizedBox(height: 10,),
                                Text("Biometric",style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    color: Colors.black
                                ),),
                              ],
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttendancePage()),
                          );
                        },
                        child: Container(
                           decoration: BoxDecoration(
                               border: Border(right: BorderSide(color: Colors.grey[300]),bottom:BorderSide(color: Colors.grey[300]) )
                           ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageAssets.attendance,height: 30,width: 30,),
                                SizedBox(height: 10,),
                                Text("Attendance",style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    color: Colors.black
                                ),),
                              ],
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingPage()),
                          );
                        },
                        child: Container(

                            decoration: BoxDecoration(
                                border: Border(bottom:BorderSide(color: Colors.grey[300]) )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageAssets.calendar,height: 30,width: 30,),
                                SizedBox(height: 10,),
                                Text("Calendar",style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    color: Colors.black
                                ),),
                              ],
                            )
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Constant.appbarTitle="Profile";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(right:BorderSide(color: Colors.grey[300]) )
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(ImageAssets.profile,height: 30,width: 30,),
                                SizedBox(height: 10,),
                                Text("Profile",style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                    color: Colors.black
                                ),),
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      );
  }
}
