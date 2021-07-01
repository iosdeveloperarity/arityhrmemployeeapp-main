import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/apiinterface/ApiInterface.dart';
import 'package:hrm_app/bloc/switchwidget.dart';
import 'package:hrm_app/model/financialyear.dart';
import 'package:hrm_app/model/user_login.dart';
import 'package:hrm_app/page/dashboard.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/utility/form_validators.dart';
import 'package:hrm_app/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation_controller.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  String _chosenValue;
  List<UserLoginData> _logindata= new List<UserLoginData>();
  TextEditingController uname= new TextEditingController();
  TextEditingController password= new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<FinancialYearData> _yeardata= new List<FinancialYearData>();
  bool isSubmitted=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getYear();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 486,
              width: 375,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 92,
                    width: 309,
                    margin: EdgeInsets.only(top: 50),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              fontFamily: 'Roboto'
                          ),),
                        Container(
                          height: 44,
                          width: 309,
                          margin: EdgeInsets.only(top: 10),
                          child: Text("HRM software that builds happy workplaces",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constant.hexStringToColor('#4B4E56'),

                                fontSize: 16,
                                fontFamily: 'Roboto'
                            ),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36,
                    width: 328,
                    margin: EdgeInsets.only(left: 25,right: 25,top: 27),
                    child: TextFormField(
                      controller: uname,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: Validators.validateEmptyField,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Username',

                        contentPadding: EdgeInsets.only(bottom: 25),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto'),
                        enabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Constant.hexStringToColor('#00BDFF')),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 36,
                    width: 328,
                    margin: EdgeInsets.only(left: 25,right: 25,top: 35),
                    child: TextFormField(
                      controller: password,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: Validators.validateEmptyField,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Password',

                        contentPadding: EdgeInsets.only(bottom: 25),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto'),
                        enabledBorder: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Constant.hexStringToColor('#00BDFF')),
                        ),
                      ),
                    ),
                  ),

              Container(
                width: 328,
                margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      value: _chosenValue,
                      items:_yeardata.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.year.toString(),style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                          ),),
                          value: item.financialYearId.toString(),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                      hint: Text(
                        "Select Year",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),

                    ),
                  ),
                ),
              ),

                  InkWell(
                    onTap: (){
                      _validateInputs(uname.text,password.text);
                      },
                    child: Container(
                      height: 48,
                      width: 328,
                      margin: EdgeInsets.only(top: 40,left: 25,right: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Constant.hexStringToColor("#37C12F")
                      ),
                      child: Center(child: Text("Login Now",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Roboto'),)),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      switchbloc.changevalueonclick(true);
                    },
                    child: Container(
                      height: 44,
                      width: 328,
                      margin: EdgeInsets.only(top: 10,left: 25,right: 25),

                      child: Center(child: Text("Forgot Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Constant.hexStringToColor('#4B4E56'),

                            fontSize: 16,
                            fontFamily: 'Roboto'
                        ),),),
                    ),
                  ),


                ],
              ),
            ),


          ],
        ),

      ),
    );
  }

  void login(String username, String password){
    String flag;

    ApiInterface().login(username, password).then((value) =>
    {
      if(value != null){
        if(value.isSuccess){
          _logindata.add(value.data),
          Constant.employee_id=_logindata[0].employeeId,
          Constant.userid=_logindata[0].userID,
          print(Constant.userid),
          addStringToSF(_logindata[0].employeeId),

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardPage()),
          ),
          Fluttertoast.showToast(
            msg: "You Have Successfully Logged In",
            fontSize: 16.0,
          ),
        }
        else
          {
            Fluttertoast.showToast(
              msg: "Invalid UserID or Password",
              fontSize: 16.0,
            ),
          }

      }
    }
    );
  }

  void getYear(){
    ApiInterface().getYear().then((value){
      if(value!=null){
        if(value.isSuccess){
          _yeardata.addAll(value.data);
          setState(() {});
        }
      }
    });
  }
  addStringToSF(String empid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emp_id', empid);
  }

  void _validateInputs(String username, String password) {
    if (_formKey.currentState.validate()) {
      setState(() {
        _formKey.currentState.save();
        login(username, password);
      });
    }
  }
}

