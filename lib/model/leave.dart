class Leave {
  List<LeaveData> data;
  bool isSuccess;
  var message;
  var exception;
  var id;
  var totalCount;

  Leave(
      {this.data,
        this.isSuccess,
        this.message,
        this.exception,
        this.id,
        this.totalCount});

  Leave.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<LeaveData>();
      json['data'].forEach((v) {
        data.add(new LeaveData.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    message = json['message'];
    exception = json['exception'];
    id = json['id'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['exception'] = this.exception;
    data['id'] = this.id;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class LeaveData {
  var employeeLeaveCategoryMapID;
  var employeeId;
  var employeeName;
  var employeeNo;
  var leaveCategoryId;
  var leaveCategory;
  var startDate;
  var endDate;
  var totalDay;
  var isFirstHalfDay;
  var isLastHalfDay;
  var reason;
  var comments;
  var applyDate;
  var approvedBy;
  var approveDate;
  var isApprove;
  var status;
  var userID;
  var email;

  LeaveData(
      {this.employeeLeaveCategoryMapID,
        this.employeeId,
        this.employeeName,
        this.employeeNo,
        this.leaveCategoryId,
        this.leaveCategory,
        this.startDate,
        this.endDate,
        this.totalDay,
        this.isFirstHalfDay,
        this.isLastHalfDay,
        this.reason,
        this.comments,
        this.applyDate,
        this.approvedBy,
        this.approveDate,
        this.isApprove,
        this.status,
        this.userID,
        this.email});

  LeaveData.fromJson(Map<String, dynamic> json) {
    employeeLeaveCategoryMapID = json['employeeLeaveCategoryMapID'];
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
    employeeNo = json['employeeNo'];
    leaveCategoryId = json['leaveCategoryId'];
    leaveCategory = json['leaveCategory'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalDay = json['totalDay'];
    isFirstHalfDay = json['isFirstHalfDay'];
    isLastHalfDay = json['isLastHalfDay'];
    reason = json['reason'];
    comments = json['comments'];
    applyDate = json['applyDate'];
    approvedBy = json['approvedBy'];
    approveDate = json['approveDate'];
    isApprove = json['isApprove'];
    status = json['status'];
    userID = json['userID'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeLeaveCategoryMapID'] = this.employeeLeaveCategoryMapID;
    data['employeeId'] = this.employeeId;
    data['employeeName'] = this.employeeName;
    data['employeeNo'] = this.employeeNo;
    data['leaveCategoryId'] = this.leaveCategoryId;
    data['leaveCategory'] = this.leaveCategory;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['totalDay'] = this.totalDay;
    data['isFirstHalfDay'] = this.isFirstHalfDay;
    data['isLastHalfDay'] = this.isLastHalfDay;
    data['reason'] = this.reason;
    data['comments'] = this.comments;
    data['applyDate'] = this.applyDate;
    data['approvedBy'] = this.approvedBy;
    data['approveDate'] = this.approveDate;
    data['isApprove'] = this.isApprove;
    data['status'] = this.status;
    data['userID'] = this.userID;
    data['email'] = this.email;
    return data;
  }
}