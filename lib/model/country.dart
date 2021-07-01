class Country {
  List<CountryData> data;
  bool isSuccess;
  var message;
  var exception;
  var id;
  int totalCount;

  Country(
      {this.data,
        this.isSuccess,
        this.message,
        this.exception,
        this.id,
        this.totalCount});

  Country.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CountryData>();
      json['data'].forEach((v) {
        data.add(new CountryData.fromJson(v));
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

class CountryData {
  String id;
  String text;
  var other;

  CountryData({this.id, this.text, this.other});

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['other'] = this.other;
    return data;
  }
}