import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrm_app/model/salaryslip.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';
import 'package:hrm_app/widgets/salarywidget.dart';

class SalaryPage extends StatefulWidget {
  @override
  _SalaryPageState createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var height;
  var width;
  String _chosenValue;
  Salary salary;
  List<Salary> _listsalary= new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Constant.appbarTitle="Salary Slip";
    salary = new Salary("April Salary Slip", "2019-20", "Function", "Approved By hradmin@arityinfoway", "2 Leave");
    _listsalary.add(salary);
    salary = new Salary("April Salary Slip", "2019-20", "Function", "Approved By hradmin@arityinfoway", "2 Leave");
    _listsalary.add(salary);
    salary = new Salary("April Salary Slip", "2019-20", "Function", "Approved By hradmin@arityinfoway", "2 Leave");
    _listsalary.add(salary);

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
                      child: Text("Salary Slip",style: TextStyle(fontSize: 24,fontFamily: 'Roboto',fontWeight: FontWeight.w500),)),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constant.hexStringToColor('#37C12F')

                    ),
                    child: Center(
                      child: SvgPicture.asset(ImageAssets.add),
                    ),

                  )
                ],
              ),
            ),
            Container(
              width: width,
              margin: EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 8),

              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Constant.hexStringToColor('#E1EBFC'))
                )
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    value: _chosenValue,
                      items:<String>[
                        'January 2020',
                        'February 2020',
                        'March 2020',
                        'April 2020',
                        'May 2020',
                        'June 2020',

                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16
                          ),),
                        );
                      }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                    hint: Text(
                      "Select Month",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _listsalary.length,
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return SalaryWidget(
                      reason: _listsalary[index].reason,
                      approved: _listsalary[index].approvedby,
                      month: _listsalary[index].month,
                      noofleaves: _listsalary[index].noofleave,
                      year: _listsalary[index].year,
                    );
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
