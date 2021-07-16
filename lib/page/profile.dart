import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/apiinterface/ApiInterface.dart';
import 'package:hrm_app/model/SaveProfile.dart';
import 'package:hrm_app/model/country.dart';
import 'package:hrm_app/model/state.dart';
import 'package:hrm_app/page/dashboard.dart';
import 'package:hrm_app/utility/constant.dart';
import 'package:hrm_app/utility/form_validators.dart';
import 'package:hrm_app/values/imageAssets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum SingingCharacter { male, female }

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var height;
  var width;
  SingingCharacter _character = SingingCharacter.female;
  bool isgender=false;
  String _chosenValue,_getcountry,getstate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController date= new TextEditingController();
  TabController _controller;
  List<CountryData> _countrylist= new List();
  List<StateData> _statelist= new List();
  List<SaveProfile> _saveprofileList= new List();
  File _image;
  final picker = ImagePicker();
  int _selectedIndex = 0;
  TextEditingController fname= new TextEditingController();
  TextEditingController lname= new TextEditingController();
  TextEditingController mname= new TextEditingController();
  TextEditingController father_name= new TextEditingController();
  TextEditingController cast= new TextEditingController();
  TextEditingController city= new TextEditingController();
  TextEditingController address= new TextEditingController();
  TextEditingController pincode= new TextEditingController();
  TextEditingController phone= new TextEditingController();
  TextEditingController mobile= new TextEditingController();
  String photo,gender="female",country,state,attendancedate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Widget> list = [
    Tab(child: Text("Personal Details",style: TextStyle(fontFamily: 'Roboto', fontSize: 16, color: Colors.black,),),),
    Tab(child: Text("Contact Details",style: TextStyle(fontFamily: 'Roboto', fontSize: 16, color: Colors.black,),)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: list.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
    getCountry();

  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(Constant.appbarTitle, style: TextStyle(
          fontFamily: 'Roboto', fontSize: 16, color: Colors.black,),),
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black,)),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: SvgPicture.asset(ImageAssets.notification)),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                child: SvgPicture.asset(ImageAssets.menu)),
          ),
        ],
        bottom: TabBar(
          onTap: (index){

          },
          controller: _controller,
          tabs: list,
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: TabBarView(
                controller: _controller,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 60),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("First Name",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  controller: fname,
                                  decoration: InputDecoration(
                                    hintText: 'First Name',
                                    contentPadding: EdgeInsets.only(left: 5),
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
                            SizedBox(height: 20,),
                            Text("Middle Name",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  controller: mname,
                                  decoration: InputDecoration(
                                    hintText: 'Middle Name',
                                    contentPadding: EdgeInsets.only(left: 5),
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
                            SizedBox(height: 20,),
                            Text("Last Name",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  controller: lname,
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    contentPadding: EdgeInsets.only(left: 5),
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
                            SizedBox(height: 20,),
                            Text("Father's Name",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  controller: father_name,
                                  decoration: InputDecoration(
                                    hintText: "Father's Name",
                                    contentPadding: EdgeInsets.only(left: 5),
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
                            SizedBox(height: 20,),
                            Text("Date of Birth",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);

                              },
                              child: AbsorbPointer(
                                child: Container(
                                  width: 140,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
                                  margin: EdgeInsets.only(top: 5),
                                  child: TextFormField(
                                    controller: date,
                                    validator: Validators.validateEmptyField,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType
                                        .datetime,
                                    decoration: InputDecoration(
                                      hintText: 'Date of Birth',
                                      contentPadding: EdgeInsets.only(left:5),
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
                            SizedBox(height: 20,),
                            Text("Gender",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              height: 40,
                              width: width,
                              child: Row(
                                children: [
                                  Text("Male",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',),),
                                  Radio<SingingCharacter>(
                                    value: SingingCharacter.male,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                        gender="male";
                                        print(gender);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 20,),
                                  Text("Female",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',),),
                                  Radio<SingingCharacter>(
                                    value: SingingCharacter.female,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                        gender = "female";
                                        print(gender);
                                      }
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Maratial Status",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,

                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300],
                                  )
                              ),
                              margin: EdgeInsets.only(top: 8),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    value: _chosenValue,
                                    items: <String>[
                                      "Married",
                                      "Unmarried",
                                      "Widowed",
                                      "Divorced",
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
                                        print(_chosenValue);
                                      });
                                    },
                                    hint: Text(
                                      "Select",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text("Cast",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  decoration: InputDecoration(
                                    hintText: "Cast",
                                    contentPadding: EdgeInsets.only(left: 5),
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
                            SizedBox(height: 20,),
                            Text("Photo",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            _image==null?Container(
                              height: 40,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      _imgFromCamera();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          "Camera",
                                          style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  InkWell(
                                    onTap: (){
                                      _imgFromGallery();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          "Gallery",
                                          style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ):Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    margin: EdgeInsets.only(top: 10),
                                    color: Colors.grey,
                                    child: Image.file(_image,fit: BoxFit.cover,),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        _image=null;
                                      });

                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 60),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Country",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300],
                                  )
                              ),
                              margin: EdgeInsets.only(top: 8),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  padding: EdgeInsets.all(20.0),
                                  child: DropdownButton(
                                    value: _getcountry,
                                    items:  _countrylist.map((item){
                                      return new DropdownMenuItem(
                                          child: Container(
                                            width: 120,
                                            child: new Text(item.text,style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                            ),),
                                          ),
                                        value: item.id,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _getcountry = value;
                                        print(_getcountry);
                                        getState(_getcountry);
                                      });
                                      },
                                    hint: Text(
                                      "Select Country",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text("State",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300],
                                  )
                              ),
                              margin: EdgeInsets.only(top: 8),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  padding: EdgeInsets.all(20.0),
                                  child: DropdownButton(
                                    value: getstate,
                                    items:  _statelist.map((item){
                                      return new DropdownMenuItem(
                                        child: new Text(item.text,style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                        ),),
                                        value: item.id.toString(),
                                      );
                                    }).toList(),
                                    onChanged: (String value) {
                                      setState(() {
                                        getstate = value;
                                        print(getstate);
                                      });
                                    },
                                    hint: Text(
                                      "Select State",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 16,
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text("City",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  controller: city,
                                  decoration: InputDecoration(
                                    hintText: 'City',
                                    contentPadding: EdgeInsets.only(left: 5),
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
                            SizedBox(height: 20,),
                            Text("Address",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  maxLines: 8,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  controller: address,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
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
                            SizedBox(height: 20,),
                            Text("Pin Code",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validateEmptyField,
                                  controller: pincode,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    hintText: 'Pincode',
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
                            SizedBox(height: 20,),
                            Text("Phone",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: Validators.validatePhone,
                                  keyboardType: TextInputType.phone,
                                  controller: phone,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    hintText: 'Phone',
                                    counterText: "",
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
                            SizedBox(height: 20,),
                            Text("Mobile",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.grey,),),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300])
                              ),
                              child: Center(
                                child: TextFormField(
                                  validator: Validators.validatePhone,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: mobile,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    hintText: 'Mobile',
                                    counterText: "",
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

                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: 60,
                color: Colors.white,
                child: Container(
                height: 60,
                width: width,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                InkWell(
                onTap:(){
                _validateInputs(fname.text,mname.text,lname.text,father_name.text,date.text,cast.text,city.text,address.text,pincode.text,phone.text,mobile.text);
                },
                child: Container(
                height: 40,
                width: 80,
                color: Colors.green,
                child: Center(
                child: Text("Save",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.white,),),
                ),
                ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                  height: 40,
                  width: 80,
                  color: Colors.red,
                  child: Center(
                  child: Text("Cancel",style: TextStyle(fontSize: 18,fontFamily: 'Roboto',color: Colors.white,),),
                  ),
                  ),
                )
                ],
                ),
                ),
              ),
            )

          ],
        )
      )
    );
  }




  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: Constant.selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null)
      setState(() {
        print(picked);
        String formatted=formatter.format(Constant.selectedDate);
        print("formatted"+formatted.toString());
        date.text=formatted;

      });

  }
  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image =  File(pickedFile.path);
      photo=_image.path.toString();
      print(photo);
      var start="Pictures/";
      final startindex=photo.indexOf(start);
      photo=photo.substring(startindex+start.length);
      print(photo);
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image =  File(pickedFile.path);
      photo=_image.path.toString();
      print(photo);
      var start="cache/";
      final startindex=photo.indexOf(start);
      photo=photo.substring(startindex+start.length);
      print(photo);
    });
  }

  void getCountry(){
    ApiInterface().getCountry().then((value){
      if(value!=null){
        _countrylist.addAll(value.data);
        _getcountry=_countrylist[1].id;
        getState(_getcountry);
        setState(() {});
      }
    });
  }

  void getState(String id){
    _statelist.clear();
    ApiInterface().getState(id).then((value){
      if(value!=null){
        _statelist.addAll(value.data);
        getstate=_statelist[0].id;
        setState(() {});
      }
    });
  }

  void _validateInputs(String fname, String mname,String lname,String fathername,String birth,String cast,String city,String address,String pincode,String phone,String mobile) {
    if(gender==null&&_chosenValue!=null&&photo!=null&&_getcountry!=null&&getstate!=null){
      Fluttertoast.showToast(msg: "Enter Gender");
    }
    else if(_chosenValue==null){
      Fluttertoast.showToast(msg: "Enter Maratial Status");
    }
    else if(photo==null){
      Fluttertoast.showToast(msg: "Set your profile image");
    }
    else if(_getcountry==null){
      Fluttertoast.showToast(msg: "Enter Country");
    }
    else if(getState==null){
      Fluttertoast.showToast(msg: "Enter State");
    }
    else if(_formKey.currentState.validate()) {
      setState(() {
        _formKey.currentState.save();
        isgender=true;
        print("Enetr");
        saveProfile();
      });
    }
  }

  void saveProfile(){

    ApiInterface().saveProfile(Constant.employee_id, fname.text, mname.text, lname.text, Constant.selectedDate.toIso8601String(), father_name.text, isgender, _chosenValue, cast.text, photo, _getcountry, getstate, city.text, address.text,
        pincode.text, mobile.text, phone.text).then((value){
          print(Constant.employee_id);
          print(fname.text);
          print(mname.text);
          print(lname.text);
          print(Constant.selectedDate.toIso8601String());
          print(father_name.text);
          print(isgender);
          print(_chosenValue);
          print(cast.text);
          print(photo);
          print(_getcountry);
          print(getstate);
          print(city.text);
          print(address.text);
          print(pincode.text);
          print(mobile.text);
          print(phone.text);

          if(value!=null){
            if(value.isSuccess==true){
              _saveprofileList.add(value);
              Fluttertoast.showToast(msg: _saveprofileList[0].message);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardPage()),
              );
            }
            else{
              Fluttertoast.showToast(msg: value.message);
            }

          }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
