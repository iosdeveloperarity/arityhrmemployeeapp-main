import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/apiinterface/ApiInterface.dart';
import 'package:hrm_app/bloc/switchwidget.dart';
import 'package:hrm_app/model/forgotpassword.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/utility/form_validators.dart';

class ForgotPasswordWidget extends StatefulWidget {
  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  StreamController<bool> _controller = StreamController<bool>();
  List<ForgotPassword> _listdata= new List<ForgotPassword>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController uname= new TextEditingController();
  bool isSubmitted=false;

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Container(
        height: 367,
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
                  Text("Forgot Password?",
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
              margin: EdgeInsets.only(left: 25,right: 25,top: 20),
              child: TextFormField(
                validator: Validators.validateEmptyField,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'Username',
                  contentPadding: EdgeInsets.only(bottom: 25),
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto'),
                  enabledBorder: InputBorder.none,
                  // enabledBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Constant.hexStringToColor('#00BDFF')),
                  // ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Constant.hexStringToColor('#00BDFF')),
                  ),
                ),
              ),
            ),


            InkWell(
              onTap: (){

                  _validateInputs(uname.text);


              },
              child: Container(
                height: 48,
                width: 328,
                margin: EdgeInsets.only(top: 40,left: 25,right: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Constant.hexStringToColor("#37C12F")
                ),
                child: Center(child: Text("Send Link",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Roboto'),)),
              ),
            ),
            InkWell(
              onTap: (){
                switchbloc.changevalueonclick(false);
              },
              child: Container(
                height: 44,
                width: 328,
                margin: EdgeInsets.only(top: 10,left: 25,right: 25),

                child: Center(child: Text("Back to Login",
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
    );
  }

  void _validateInputs(String username) {
    if (_formKey.currentState.validate()) {
      setState(() {
        _formKey.currentState.save();
        forgotpassword(username);
      });
    }
  }

  void forgotpassword(String username){
    String flag;

    ApiInterface().forgotpassword(username).then((value) => {
      if(value!=null){
        if(value.isSuccess){
          _listdata.add(value),
          Fluttertoast.showToast(
            msg: "Password reset link is being sent to your mail",
            fontSize: 16.0,
          ),
        }
        else{
          Fluttertoast.showToast(
            msg: "This username is not registered with us",
            fontSize: 16.0,
          ),

        }

      }

    }
    );
  }
}
