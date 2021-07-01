import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrm_app/bloc/appbarbloc.dart';
import 'package:hrm_app/page/attendancepage.dart';
import 'package:hrm_app/page/calendarpage.dart';
import 'package:hrm_app/page/homepage.dart';
import 'package:hrm_app/page/salarypage.dart';
import 'package:hrm_app/page/settingpage.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  PersistentTabController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appbarswitchbloc.changevalueonclick(false);
    _controller = PersistentTabController(initialIndex: 2);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(Constant.appbarTitle,style: TextStyle(fontFamily: 'Roboto',fontSize: 16,color: Colors.black),),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,)),
        backgroundColor:Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
              child: SvgPicture.asset(ImageAssets.notification)),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: (){
                _scaffoldKey.currentState.openDrawer();
              },
                child: SvgPicture.asset(ImageAssets.menu)),
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerWidget()
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
    items: _navBarsItems(),
    navBarHeight: 71,

    confineInSafeArea: true,
    onItemSelected: (index){
      setState(() {
        switch(index) {
          case 0: { Constant.appbarTitle = 'Clock In Time'; }
          break;
          case 1: { Constant.appbarTitle = 'Pay Slip'; }
          break;
          case 2: { Constant.appbarTitle = 'Attendance'; appbarswitchbloc.changevalueonclick(true);}
          break;
          case 3: { Constant.appbarTitle = 'Calendar'; appbarswitchbloc.changevalueonclick(true); }
          break;
          case 4: { Constant.appbarTitle = 'Settings'; }
          break;
        }
      });
    },
    backgroundColor: Colors.white, // Default is Colors.white.
    handleAndroidBackButtonPress: true, // Default is true.
    resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    stateManagement: true, // Default is true.
    hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    decoration: NavBarDecoration(
    // borderRadius: BorderRadius.circular(10.0),
    colorBehindNavBar: Colors.white,
    ),
    popAllScreensOnTapOfSelectedTab: true,
    popActionScreens: PopActionScreensType.all,
    itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
    duration: Duration(milliseconds: 200),
    curve: Curves.ease,
    ),
    screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
    animateTabTransition: true,
    curve: Curves.ease,
    duration: Duration(milliseconds: 200),
    ),
    navBarStyle: NavBarStyle.style13,     // Choose the nav bar style with this property.
    ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      SalaryPage(),
      AttendancePage(),
      CalendarPage(),
      SettingPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(ImageAssets.home,height: 20,width: 25,),
        title: ("Home"),
        activeColorPrimary: Constant.hexStringToColor("#37C12F"),
        activeColorSecondary: Constant.hexStringToColor("#37C12F"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(ImageAssets.payroll,height: 21,width: 15,),
        title: ("salary"),
        activeColorPrimary: Constant.hexStringToColor("#37C12F"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          height: 48,
            width: 48,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constant.hexStringToColor('#00BDFF')
            ),
            child: SvgPicture.asset(ImageAssets.biofinder,height: 17,width: 17,)),

      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(ImageAssets.calendar),
        title: ("Calendar"),
        activeColorPrimary: Constant.hexStringToColor("#37C12F"),
        activeColorSecondary: Constant.hexStringToColor("#37C12F"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(ImageAssets.setting),
        title: ("Settings"),
        activeColorPrimary: Constant.hexStringToColor("#37C12F"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
