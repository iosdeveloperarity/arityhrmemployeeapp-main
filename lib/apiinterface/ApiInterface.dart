import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrm_app/model/SaveProfile.dart';
import 'package:hrm_app/model/attendancecheck.dart';
import 'package:hrm_app/model/country.dart';
import 'package:hrm_app/model/financialyear.dart';
import 'package:hrm_app/model/forgotpassword.dart';
import 'package:hrm_app/model/leave.dart';
import 'package:hrm_app/model/state.dart';
import 'package:hrm_app/model/user_login.dart';
import 'package:hrm_app/utility/constant.dart';

class ApiInterface{
  static const baseUrl = "http://demoby.arityinfoway.com:8120/api/ERP/";
  final Dio _dio = Dio();

  Future<UserLogin> login(String username, String password) async {
    print(username);
    print(password);
    String url = baseUrl + "UserLogin";
    // _dio.options.contentType = 'application/json';
    // _dio.options.headers["X-AUTH-TOKEN"] = Constant.auth_token;
    Map data ={
      "Username":username,
      "Password":password
    };
    var body=json.encode(data);
    FormData form = FormData.fromMap({"Username": username, "Password": password});
    try {
      Response response = await _dio.post(url, data: body,options: Options(

        headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter");

        print("Response : " + response.toString());

        return UserLogin.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ForgotPassword> forgotpassword(String username) async {
    print(username);
    String url = baseUrl + "ForgotPassword";
    Map data ={
      "Username":username,
    };
    var body=json.encode(data);
    FormData form = FormData.fromMap({"Username": username});

    try {
      Response response = await _dio.post(url, data: data,options: Options(

          headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter");


        print("Response : " + response.toString());

        return ForgotPassword.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  // Future<ForgotPassword> forgotpassword(String username) async {
  //   print(username);
  //   String url = baseUrl + "UserLogin";
  //   Map data ={
  //     "Username":username,
  //   };
  //   var body=json.encode(data);
  //   FormData form = FormData.fromMap({"Username": username});
  //
  //   try {
  //     Response response = await _dio.post(url, data: data,options: Options(
  //
  //         headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
  //     ));
  //     if (response.statusCode == 200) {
  //       print("Enter");
  //
  //
  //       print("Response : " + response.toString());
  //
  //       return ForgotPassword.fromJson(response.data);
  //     } else
  //       return null;
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return null;
  //   }
  // }

  Future<Leave> getLeaves(String empid) async {
    print(empid);
    String url = baseUrl + "GetLeaveDetailList?p_EmployeeId="+"{"+empid+"}";
    FormData form = FormData.fromMap({"p_EmployeeId": empid});

    try {
      Response response = await _dio.post(url, data: form,options: Options(

          headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter");
        print("Response : " + response.toString());

        return Leave.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<FinancialYear> getYear() async {
    String url = baseUrl + "GetFinacialYearList";

    try {
      Response response = await _dio.post(url,options: Options(

          headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter");
        print("Response : " + response.toString());

        return FinancialYear.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Country> getCountry() async {
    String url = baseUrl + "GetCountryList";

    try {
      Response response = await _dio.post(url,options: Options(

          headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter");
        print("Response : " + response.toString());

        return Country.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<StateList> getState(String countryid) async {
    String url = baseUrl + "GetStateList?CountryId="+"{"+countryid+"}";
    try {
      Response response = await _dio.post(url,options: Options(
          headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter HERE");
        print(response.data);
        return StateList.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<AttendanceCheck> puchINOUT(String longitude, String latitude, String locationname, String employeeID,String attendancedate,String punchmethod, String enrollno) async {

    String url = baseUrl + "SaveAttendance";
    // _dio.options.contentType = 'application/json';
    // _dio.options.headers["X-AUTH-TOKEN"] = Constant.auth_token;
    Map data ={
      "Latitude":latitude,
      "Longitude":longitude,
      "LocationName":locationname,
      "EmployeeId": employeeID,
      "AttendanceDate":attendancedate,
      "PunchMethod":punchmethod,
      "EnrollNo":enrollno
    };
    var body=json.encode(data);
    try {
      Response response = await _dio.post(url, data: body,options: Options(

          headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter");

        print("Response : " + response.toString());

        return AttendanceCheck.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<SaveProfile> saveProfile(String empid,String firstName,String middleName,String lastName,DateTime birth,
      String fatherName,bool isGender,String maratialStatus,String cast,String photoName, var countryId, var stateId, String city,
      String address,String pincode,String mobileno,String phoneno) async {
    // _dio.options.contentType = 'application/json';
    // _dio.options.headers["X-AUTH-TOKEN"] = Constant.auth_token;

    String url = baseUrl + "SaveProfile";
    var str = json.encode(birth, toEncodable: myEncode);
    Map data ={
      "employeeID": empid,
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "birthDate": str,
      "fatherName": fatherName,
      "isGender": isGender,
      "maratialStatus": maratialStatus,
      "cast": cast,
      "photoName":photoName,
      "countryId": countryId,
      "stateId": stateId,
      "city": city,
      "address": address,
      "pinCode": pincode,
      "mobileNo": mobileno,
      "phoneNo": phoneno
    };
    var body=json.encode(data);
    try {
      Response response = await _dio.post(url, data: body,options: Options(

          headers: {'Content-Type': 'application/json','X-AUTH-TOKEN': Constant.auth_token}
      ));
      if (response.statusCode == 200) {
        print("Enter");

        print("Response : " + response.toString());

        return SaveProfile.fromJson(response.data);
      } else
        return null;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;

    }
  }
}

dynamic myEncode(dynamic item) {
  if(item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}