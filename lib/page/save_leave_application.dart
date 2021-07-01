import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/utility/form_validators.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:hrm_app/widgets/drawerwidget.dart';
import 'package:intl/intl.dart';

class SaveLeaveApplicationPage extends StatefulWidget {
  @override
  _SaveLeaveApplicationPageState createState() => _SaveLeaveApplicationPageState();
}

class _SaveLeaveApplicationPageState extends State<SaveLeaveApplicationPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var height;
  var width;
  String _chosenValue;
  bool checkedValue=false;
  bool checkValuetwo=false;
  bool isempty=false;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController startdate= new TextEditingController();
  TextEditingController enddate= new TextEditingController();
  TextEditingController reason= new TextEditingController();
  TextEditingController total_leave= new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double preservedDifference;

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
      body: Form(
        key: _formKey,
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0 )
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Apply Leave Application",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.w500,color: Colors.green),),
                Divider(
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text("Employee Name: ",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.grey),),
                      Text("Arity Infoway",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Leave Category",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.grey),),
                ),
                Container(
                  width: width,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                    )
                  ),
                  margin: EdgeInsets.only(top: 8),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      padding: EdgeInsets.all(10.0),
                      child: DropdownButton(
                        value: _chosenValue,
                        items: <String>[
                          "Annual Leave",
                          "Emergancy Leave",
                          "Normal Leave",
                          "Others",
                          "Planned Leave",
                          "Sick Leave",
                          "Test",
                          "Un-planned Leave"
                        ].map<DropdownMenuItem<String>>((String value){
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
                          "Select Leave Category",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                          ),
                        ),

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text("Consider Half Leave",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.grey),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: [
                      Checkbox(
                      value: checkedValue,
                        onChanged: _onRememberMeChanged
                      ),
                      Text("Start Date Half Leave",style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Colors.black,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: checkValuetwo,
                        onChanged: _onRememberMeChangedtwo,
                      ),
                      Text("End Date Half Leave",style: TextStyle(fontSize: 14,fontFamily: 'Roboto',color: Colors.black,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Reason",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.grey),),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                      ),
                      child: TextFormField(
                        maxLines: 8,
                        autofocus: false,
                        controller: reason,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: Validators.validateEmptyField,
                        decoration: InputDecoration.collapsed(),
                      ),
                    )
                  ],
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Leaves",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.grey),),
                      SizedBox(height: 10,),
                      Text("12 (Total Leaves) - 0.5(Used Leaves) = 11.5(Left Leaves)",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.black,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Start Date-End Date",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.grey),),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectDate(context,"Start");
                              },
                              child: AbsorbPointer(
                                child: Container(
                                  width: 140,
                                  margin: EdgeInsets.only(left: 10,right: 10,),
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: TextFormField(
                                    controller: startdate,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: Validators.validateEmptyField,
                                    keyboardType: TextInputType
                                        .datetime,
                                    decoration: InputDecoration(
                                      hintText: 'Date',
                                      // contentPadding: EdgeInsets.only(bottom: 25),
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto'),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constant
                                                .hexStringToColor(
                                                '#00BDFF')),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context,"End");
                              },
                              child: AbsorbPointer(
                                child: Container(
                                  width: 140,
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: TextFormField(
                                    controller: enddate,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: Validators.validateEmptyField,
                                    keyboardType: TextInputType
                                        .datetime,
                                    decoration: InputDecoration(
                                      hintText: 'Date',
                                      // contentPadding: EdgeInsets.only(bottom: 25),
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto'),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constant
                                                .hexStringToColor(
                                                '#00BDFF')),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Leave",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.grey),),
                      Container(
                        width: width,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                        ),
                        child: TextFormField(
                          maxLines: 2,
                          autofocus: false,
                          controller: total_leave,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.validateEmptyField,
                          decoration: InputDecoration.collapsed(),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          _validateInputs(_chosenValue, reason.text, startdate.text, enddate.text, total_leave.text);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          color: Colors.green,
                          child: Center(
                            child: Text("Apply",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          color: Colors.red,
                          child: Center(
                            child: Text("Cancle",style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<Null> _selectDate(BuildContext context,String name) async {
    var one,two;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: Constant.selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null)
      setState(() {
        Constant.selectedDate = picked;
        String formatted=formatter.format(Constant.selectedDate);
        if(name=="Start"){
          datevalidation(name,formatted.toString());
        }
        else{
          datevalidation(name,formatted.toString());
        }

      });

  }
  void _onRememberMeChanged(bool newValue) => setState(() {
    checkedValue = newValue;
      if (checkedValue) {
        if(total_leave.text!=""){
          double total=double.parse(total_leave.text);
          halfleavecalculation(total);
        }

      } else {
        if(total_leave.text!=""){
          double total=double.parse(total_leave.text);
          halfleavecalculation(total);
        }
      }

  });
  void _onRememberMeChangedtwo(bool newValue) => setState(() {
    checkValuetwo = newValue;
    if (checkValuetwo) {
      if(total_leave.text!=""){
        double total=double.parse(total_leave.text);
        halfleavecalculation(total);
      }

    } else {
      if(total_leave.text!=""){
        double total=double.parse(total_leave.text);
        halfleavecalculation(total);
      }
    }

  });
  void _validateInputs(String leave_cat,String reason,String startdate,String enddate,String totalleave) {
    if(leave_cat==null){
      Fluttertoast.showToast(msg: "Select Leave Category");
    }
    else if(_formKey.currentState.validate()) {
      setState(() {
        _formKey.currentState.save();
      });
    }
  }

  void datevalidation(String name, String formatted){
    var date=DateTime.now();
    var df1 = formatter.parse(formatted);
    print(df1);
    var df2 = formatter.parse(date.toString());
    if(df1.isBefore(df2)){
      Fluttertoast.showToast(msg: "Please Select Appropriate Date");
    }
    else{
      if(name=="Start"){
        startdate.text=formatted.toString();
      }
      else{
        enddate.text=formatted.toString();
      }

    }
    final difference = df1.difference(df2).inDays;
    preservedDifference=difference.toDouble();
    print(difference);
    print(preservedDifference);
    if(difference!=null && difference>=0){
      halfleavecalculation(difference.toDouble());
    }
  }
  void halfleavecalculation(double difference){
    print(difference);
    difference=preservedDifference;
    if(checkedValue==false && checkValuetwo==false)
    {
      total_leave.text=difference.toString();
    }
    else if(checkedValue==true &&checkValuetwo==false){
      var totalvalue=difference-0.5;
      total_leave.text=totalvalue.toString();
    }
    else if(checkedValue==false && checkValuetwo==true)
    {
      var totalvalue=difference-0.5;
      total_leave.text=totalvalue.toString();
    }
    else if(checkedValue==true && checkValuetwo==true){
      var totalvalue=difference-1;
      if(totalvalue < 0){
        totalvalue=0;
      }
      total_leave.text=totalvalue.toString();
    }
    setState(() {});
  }
}
