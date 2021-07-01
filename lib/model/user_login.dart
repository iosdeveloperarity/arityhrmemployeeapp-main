class UserLogin {
  UserLoginData data;
  bool isSuccess;
  String message;
  Exception exception;
  String id;
  int totalCount;

  UserLogin(
      {this.data,
        this.isSuccess,
        this.message,
        this.exception,
        this.id,
        this.totalCount});

  UserLogin.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserLoginData.fromJson(json['data']) : null;
    isSuccess = json['isSuccess'];
    message = json['message'];
    exception = json['exception'] != null
        ? new Exception.fromJson(json['exception'])
        : null;
    id = json['id'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.exception != null) {
      data['exception'] = this.exception.toJson();
    }
    data['id'] = this.id;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class UserLoginData {
  String userID;
  String financialYearId;
  String roleId;
  String email;
  String fullName;
  String photoName;
  String employeeId;
  int employeeNo;

  UserLoginData(
      {this.userID,
        this.financialYearId,
        this.roleId,
        this.email,
        this.fullName,
        this.photoName,
        this.employeeId,
        this.employeeNo});

  UserLoginData.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    financialYearId = json['financialYearId'];
    roleId = json['roleId'];
    email = json['email'];
    fullName = json['fullName'];
    photoName = json['photoName'];
    employeeId = json['employeeId'];
    employeeNo = json['employeeNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['financialYearId'] = this.financialYearId;
    data['roleId'] = this.roleId;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['photoName'] = this.photoName;
    data['employeeId'] = this.employeeId;
    data['employeeNo'] = this.employeeNo;
    return data;
  }
}

class Exception {
  String className;
  Null message;
  Null data;
  Null innerException;
  String helpURL;
  Null stackTraceString;
  Null remoteStackTraceString;
  int remoteStackIndex;
  Null exceptionMethod;
  int hResult;
  String source;
  Null watsonBuckets;

  Exception(
      {this.className,
        this.message,
        this.data,
        this.innerException,
        this.helpURL,
        this.stackTraceString,
        this.remoteStackTraceString,
        this.remoteStackIndex,
        this.exceptionMethod,
        this.hResult,
        this.source,
        this.watsonBuckets});

  Exception.fromJson(Map<String, dynamic> json) {
    className = json['ClassName'];
    message = json['Message'];
    data = json['Data'];
    innerException = json['InnerException'];
    helpURL = json['HelpURL'];
    stackTraceString = json['StackTraceString'];
    remoteStackTraceString = json['RemoteStackTraceString'];
    remoteStackIndex = json['RemoteStackIndex'];
    exceptionMethod = json['ExceptionMethod'];
    hResult = json['HResult'];
    source = json['Source'];
    watsonBuckets = json['WatsonBuckets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassName'] = this.className;
    data['Message'] = this.message;
    data['Data'] = this.data;
    data['InnerException'] = this.innerException;
    data['HelpURL'] = this.helpURL;
    data['StackTraceString'] = this.stackTraceString;
    data['RemoteStackTraceString'] = this.remoteStackTraceString;
    data['RemoteStackIndex'] = this.remoteStackIndex;
    data['ExceptionMethod'] = this.exceptionMethod;
    data['HResult'] = this.hResult;
    data['Source'] = this.source;
    data['WatsonBuckets'] = this.watsonBuckets;
    return data;
  }
}