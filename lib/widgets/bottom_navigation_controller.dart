import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/page/attendancepage.dart';
import 'package:hrm_app/page/calendarpage.dart';
import 'package:hrm_app/page/homepage.dart';
import 'package:hrm_app/page/leavedetails.dart';
import 'package:hrm_app/page/salarypage.dart';
import 'package:hrm_app/page/settingpage.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';


class BottomNavigationBarController extends StatefulWidget {
  BottomNavigationBarController({Key key}) : super(key: key);

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<int> _history = [0];

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  List<Widget> mainTabs;
  List<BuildContext> navStack = [
    null,
    null,
    null,
    null,
    null
  ]; // one buildContext for each tab to store history  of navigation

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 5);
    mainTabs = <Widget>[
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
          navStack[0] = context;
          return HomePage();
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
          navStack[1] = context;
          return SalaryPage();
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
          navStack[2] = context;
          return AttendancePage();
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
          navStack[3] = context;
          return LeaveDetailsPage();
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
          navStack[4] = context;
          return SettingPage();
        });
      }),
    ];
    super.initState();
  }

  final List<BottomNavigationBarRootItem> bottomNavigationBarRootItems = [
    BottomNavigationBarRootItem(
        bottomNavigationBarItem: BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageAssets.home,color: Colors.black,),
          title: Text('Home'),
        ),
        nestedNavigator: null,
        routeName: null),
    BottomNavigationBarRootItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: SvgPicture.asset(ImageAssets.payroll),
        title: Text('Salary'),
      ),
      nestedNavigator: null,
      routeName: null,
    ),
    BottomNavigationBarRootItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon: SvgPicture.asset(ImageAssets.biofinder,),
        title: Text('Finder'),
      ),
      nestedNavigator: null,
      routeName: null,
    ),
    BottomNavigationBarRootItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon:SvgPicture.asset(ImageAssets.calendar),
        title: Text('attendance'),
      ),
      nestedNavigator: null,
      routeName: null,
    ),
    BottomNavigationBarRootItem(
      bottomNavigationBarItem: BottomNavigationBarItem(
        icon:SvgPicture.asset(ImageAssets.setting),
        title: Text('setting'),
      ),
      nestedNavigator: null,
      routeName: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(


          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: mainTabs,
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            height: 56,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                      _onItemTapped(_selectedIndex);
                      Constant.appbarTitle="Clock In Time";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: _selectedIndex == 0
                        ? BoxDecoration(
                           border: Border(

                             bottom: BorderSide(color: Constant.hexStringToColor("#37C12F"),)
                           )
                          )
                        : BoxDecoration(color: Colors.transparent),
                    child: SvgPicture.asset(ImageAssets.home,color: _selectedIndex==0?Constant.hexStringToColor('#37C12F'):Constant.hexStringToColor('#97A4C1')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                      _onItemTapped(_selectedIndex);

                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: _selectedIndex == 1
                        ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Constant.hexStringToColor("#37C12F"))
                        )
                          )
                        : BoxDecoration(color: Colors.white),
                    child: SvgPicture.asset(ImageAssets.payroll,height: 17,width: 17,color: _selectedIndex==1?Constant.hexStringToColor('#37C12F'):Constant.hexStringToColor('#97A4C1')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                      _onItemTapped(_selectedIndex);
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(color: Constant.hexStringToColor("#00BDFF"),shape: BoxShape.circle),
                    child: SvgPicture.asset(ImageAssets.biofinder,color: Colors.white,height: 17,width: 17,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                      _onItemTapped(_selectedIndex);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: _selectedIndex == 3
                        ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Constant.hexStringToColor("#37C12F"))
                        )
                          )
                        : BoxDecoration(color: Colors.white),
                    child:  SvgPicture.asset(ImageAssets.calendar,color: _selectedIndex==3?Constant.hexStringToColor('#37C12F'):Constant.hexStringToColor('#97A4C1')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                      _onItemTapped(_selectedIndex);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: _selectedIndex == 4
                        ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Constant.hexStringToColor("#37C12F"))
                        )
                    )
                        : BoxDecoration(color: Colors.white),
                    child:  SvgPicture.asset(ImageAssets.setting,color: _selectedIndex==4?Constant.hexStringToColor('#37C12F'):Constant.hexStringToColor('#97A4C1')),
                  ),
                ),
              ],
            ),
          )),
      onWillPop: () async {
        if (Navigator.of(navStack[_tabController.index]).canPop()) {
          Navigator.of(navStack[_tabController.index]).pop();
          setState(() {
            _selectedIndex = _tabController.index;
          });
          return false;
        } else {
          if (_tabController.index == 0) {
            setState(() {
              _selectedIndex = _tabController.index;
            });
            SystemChannels.platform
                .invokeMethod('SystemNavigator.pop'); // close the app
            return true;
          } else {
            _tabController.index =
                0; // back to first tap if current tab history stack is empty
            setState(() {
              _selectedIndex = _tabController.index;
            });
            return false;
          }
        }
      },
    );
  }

  void _onItemTapped(int index) {
    _tabController.index = index;
    setState(() => _selectedIndex = index);
  }
}

class BottomNavigationBarRootItem {
  final String routeName;
  final NestedNavigator nestedNavigator;
  final BottomNavigationBarItem bottomNavigationBarItem;

  BottomNavigationBarRootItem({
    @required this.routeName,
    @required this.nestedNavigator,
    @required this.bottomNavigationBarItem,
  });
}

abstract class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  NestedNavigator({Key key, @required this.navigatorKey}) : super(key: key);
}

class HomeNavigator extends NestedNavigator {
  HomeNavigator({Key key, @required GlobalKey<NavigatorState> navigatorKey})
      : super(
          key: key,
          navigatorKey: navigatorKey,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => HomePage();
              break;
            case '/home/1':
              builder = (BuildContext context) => AttendancePage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }
}

// BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           items: bottomNavigationBarRootItems
//               .map((e) => e.bottomNavigationBarItem)
//               .toList(),
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           onTap: _onItemTapped,
//         ),
