import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';

class SalaryWidget extends StatefulWidget {
  final String month;
  final String year;
  final String reason;
  final String approved;
  final String noofleaves;

  const SalaryWidget({Key key, this.month, this.year, this.reason, this.approved, this.noofleaves}) : super(key: key);
  @override
  _SalaryWidgetState createState() => _SalaryWidgetState();
}

class _SalaryWidgetState extends State<SalaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168,
      width: 327,
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
                child: Text(widget.month,style: TextStyle(fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10,top: 10),
                child: Row(
                  children: [
                   SvgPicture.asset(ImageAssets.download)

                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10,top: 8),
            child: Row(
              children: [
                Text("Fin Year: "+widget.year,style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),),

              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 10,top: 20),
                child: Text(widget.reason,style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),)
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 10,top: 8),
                child: Text(widget.approved,style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),)
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(left: 10,top: 8),
                child: Text(widget.noofleaves,style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Constant.hexStringToColor('#43425D')),)
            ),
          )
        ],
      ),
    );
  }
}
