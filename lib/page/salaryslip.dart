import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';

class SalarySlipPage extends StatefulWidget {
  @override
  _SalarySlipPageState createState() => _SalarySlipPageState();
}

class _SalarySlipPageState extends State<SalarySlipPage> {
  var height;
  var width;
  DateTime _currentDate = DateTime(2019, 2, 3);
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',

          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',

        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',

        ),
      ],
    },
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    height= MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,

        elevation: 0.0,
        title: Text(Constant.appbarTitle,style: TextStyle(fontFamily: 'Roboto',fontSize: 16,color: Colors.white),),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,)),
        backgroundColor:Constant.hexStringToColor("#00BDFF"),
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,

              child: Column(
                children: [
                  Container(
                    height: 248,
                    width: 375,
                    color: Constant.hexStringToColor('#00BDFF'),
                    child:Center(
                      child: Text("Pay Slip",style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          color: Colors.white
                      ),),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 49,
                        width: 157,
                        margin: EdgeInsets.only(top: 260,right: 4,left: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Constant.hexStringToColor('#37C12F')
                        ),
                        child: Center(
                          child: Text("PAY SLIP",style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              color: Colors.white
                          ),),
                        ),
                      ),
                      Container(
                        height: 49,
                        width: 157,
                        margin: EdgeInsets.only(top: 260,right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Constant.hexStringToColor('#00BDFF')
                        ),
                        child: Center(
                          child: Text("VIEW",style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                height: 320,
                width: 320,
                margin: EdgeInsets.only(top: 177),

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
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
                      customDayBuilder: (   /// you can provide your own build function to make custom day containers
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
                        /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                        /// This way you can build custom containers for specific days only, leaving rest as default.

                        // Example: every 15th of month, we have a flight, we can place an icon in the container like that:

                      },
                      weekFormat: false,
                      markedDatesMap: _markedDateMap,
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
                          ),
                          SizedBox(width: 20,),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: Colors.purpleAccent,
                                    shape: BoxShape.circle
                                ),

                              ),
                              SizedBox(width: 5,),
                              Text("Holiday",style: TextStyle(
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
