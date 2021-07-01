import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrm_app/apiinterface/ApiInterface.dart';
import 'package:hrm_app/model/leave.dart';
import 'package:hrm_app/page/save_leave_application.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';
import 'package:hrm_app/widgets/leavewidget.dart';
import 'package:intl/intl.dart';

class LeaveDetailsPage extends StatefulWidget {
  @override
  _LeaveDetailsPageState createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var height;
  var width;
  Leave leave;
  List<LeaveData> _listLeave= new List();
  Future _leaveApi;
  String nodata="";
  final DateFormat formatter = DateFormat('dd-MM-YYYY');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Constant.appbarTitle="Leave Details";
    getLeaves(Constant.employee_id);
  }
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerWidget(),
      key: _scaffoldKey,
      appBar: AppBar(
      centerTitle: true,
      elevation: 0.0,
      title: Text(Constant.appbarTitle,style: TextStyle(fontFamily: 'Roboto',fontSize: 16,color: Colors.black),),
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
          child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.black,)),
      backgroundColor: Colors.white,
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
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment:Alignment.center,
                      child: Text("Leave Details",style: TextStyle(fontSize: 24,fontFamily: 'Roboto',fontWeight: FontWeight.w500),)),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SaveLeaveApplicationPage()),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constant.hexStringToColor('#37C12F')

                      ),
                      child: Center(
                        child: SvgPicture.asset(ImageAssets.add),
                      ),

                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _leaveApi,
                initialData: [],
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.done)
                    return nodata!="No data available"?
                      ListView.builder(
                        itemCount: _listLeave.length,
                        shrinkWrap: true,
                        //physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          LeaveData leavedata= _listLeave[index];
                          return LeaveWidget(leavetype: leavedata.leaveCategory,
                            enddate: leavedata.endDate,
                            startdate:leavedata.startDate,
                            noofleave: leavedata.totalDay.toString(),
                            approvedby: leavedata.approvedBy,
                            reason: leavedata.reason,
                            leave_status: leavedata.status,);
                        }
                      ):Center(child: Text(
                      "No Data Available",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto'
                      ),
                    ),);

                  else{
                    return CupertinoActivityIndicator();
                  }
                },

              ),
            )
          ],
        ),
      ),
    );
  }

  getLeaves(String empid){
   _leaveApi= ApiInterface().getLeaves(empid).then((value){
      if(value!=null){
        _listLeave.addAll(value.data);
        print(_listLeave.length);
        if(_listLeave.isEmpty){
          nodata=="No data available";
        }
      }
    });
  }
}
