import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hrm_app/bloc/switchtimewidget.dart';
import 'package:hrm_app/bloc/switchwidget.dart';
import 'package:hrm_app/utility/bottomsheet.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/values/imageAssets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var height;
  var width;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchbloc.changevalueonclick(false);
  }

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.splashBG),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(ImageAssets.splashLogo,height: 56,width: 160,),
            Center(
              child: Container(
                height: 44,
                width: 309,
                margin: EdgeInsets.only(top: 30),
                child: Text("HRMs software that builds happy workplaces",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Colors.white,

                  fontSize: 16,
                      fontFamily: 'Roboto'
                ),),
              ),
            ),
            Center(
              child: InkWell(
                onTap: (){
                  BottomSheetForLogin().modalBottomSheetMenu(context);
                },
                child: Container(
                  height: 48,
                  width: 318,
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Constant.hexStringToColor("#37C12F")
                  ),
                  child: Center(child: Text("GET STARTED",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Roboto'),)),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                BottomSheetForLogin().modalBottomSheetMenu(context);
              },
              child: Center(
                child: Container(
                  height: 20,
                  width: 262,
                  margin: EdgeInsets.only(top: 40,bottom: 50),

                  child: Center(child: RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',

                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: Constant.hexStringToColor("#00BDFF"),
                            fontSize: 16,
                            fontFamily: 'Roboto'
                          )
                        )
                      ]
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
