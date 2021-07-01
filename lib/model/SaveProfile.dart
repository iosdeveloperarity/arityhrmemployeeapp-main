class SaveProfile {
  bool data;
  bool isSuccess;
  String message;
  Exception exception;
  String id;
  int totalCount;

  SaveProfile(
      {this.data,
        this.isSuccess,
        this.message,
        this.exception,
        this.id,
        this.totalCount});

  SaveProfile.fromJson(Map<String, dynamic> json) {
    data = json['data'];
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
    data['data'] = this.data;
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

class Exception {
  String className;
  var message;
  var data;
  var innerException;
  String helpURL;
  var stackTraceString;
  var remoteStackTraceString;
  int remoteStackIndex;
  var exceptionMethod;
  int hResult;
  String source;
  var watsonBuckets;

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