import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:intl/intl.dart';

class LeaveWidget extends StatefulWidget {
  final String leavetype;
  final String startdate;
  final String enddate;
  final String reason;
  final String approvedby;
  final String noofleave;
  final String leave_status;

  const LeaveWidget({Key key, this.leavetype, this.startdate, this.enddate, this.reason, this.approvedby, this.noofleave, this.leave_status}) : super(key: key);
  @override
  _LeaveWidgetState createState() => _LeaveWidgetState();
}

class _LeaveWidgetState extends State<LeaveWidget> {

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  String startdate,enddate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startdate = formatter.format(DateTime.parse(widget.startdate));
    enddate = formatter.format(DateTime.parse(widget.enddate));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      padding: EdgeInsets.only(bottom: 6.0),
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
        color: Constant.hexStringToColor("#E1EBFC"),
        ),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text(widget.leavetype,style: TextStyle(fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10,top: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(ImageAssets.edit),
                    SizedBox(width: 10,),
                    SvgPicture.asset(ImageAssets.remove),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10,top: 8),
            child: Row(
              children: [
                Text(startdate,style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),),
                Text(" - ",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),),
                Text(enddate,style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10,top: 20),
                child: Text("Reason : "+widget.reason,style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),)
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 10,top: 8),
                child: Row(
                  children: [
                    Text("Approved By : ",style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),),
                    Text(widget.approvedby!=null?widget.approvedby:" ",style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),),
                  ],
                )
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 10,top: 8),
                child: Text("Total Leaves : "+widget.noofleave,style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),)
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 10,top: 8),
                child: Text("Leave Status : "+widget.leave_status,style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),)
            ),
          )
        ],
      ),
    );
  }
}
