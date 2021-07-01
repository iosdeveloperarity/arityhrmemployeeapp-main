class FinancialYear {
  List<FinancialYearData> data;
  bool isSuccess;
  var message;
  var exception;
  var id;
  int totalCount;

  FinancialYear(
      {this.data,
        this.isSuccess,
        this.message,
        this.exception,
        this.id,
        this.totalCount});

  FinancialYear.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<FinancialYearData>();
      json['data'].forEach((v) {
        data.add(new FinancialYearData.fromJson(v));
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

class FinancialYearData {
  String financialYearId;
  String financialYearText;
  int year;

  FinancialYearData({this.financialYearId, this.financialYearText, this.year});

  FinancialYearData.fromJson(Map<String, dynamic> json) {
    financialYearId = json['financialYearId'];
    financialYearText = json['financialYearText'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financialYearId'] = this.financialYearId;
    data['financialYearText'] = this.financialYearText;
    data['year'] = this.year;
    return data;
  }
}