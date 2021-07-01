class AttendanceCheck {
  var data;
  var isSuccess;
  var message;
  var exception;
  var id;
  int totalCount;

  AttendanceCheck(
      {this.data,
        this.isSuccess,
        this.message,
        this.exception,
        this.id,
        this.totalCount});

  AttendanceCheck.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    exception = json['exception'];
    id = json['id'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['exception'] = this.exception;
    data['id'] = this.id;
    data['totalCount'] = this.totalCount;
    return data;
  }
}