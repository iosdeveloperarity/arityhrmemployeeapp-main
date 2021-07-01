import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrm_app/bloc/switchwidget.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/widgets/forgotpasswordwidget.dart';
import 'package:hrm_app/widgets/loginwidget.dart';

class BottomSheetForLogin{

  void modalBottomSheetMenu(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (builder){
          return StreamBuilder(
            stream: switchbloc.changevalue,
            builder: (context,AsyncSnapshot<bool> snapshot){
                return new Container(
                    height: 600.0,
                    child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0))),
                        child: snapshot.data==true ? ForgotPasswordWidget():LoginWidget()),
              );


            },

          );
        }
    );
  }
}

