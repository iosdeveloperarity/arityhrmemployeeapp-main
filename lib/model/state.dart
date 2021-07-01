class StateList {
  List<StateData> data;
  bool isSuccess;
  var message;
  var exception;
  var id;
  int totalCount;

  StateList(
      {this.data,
        this.isSuccess,
        this.message,
        this.exception,
        this.id,
        this.totalCount});

  StateList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<StateData>();
      json['data'].forEach((v) {
        data.add(new StateData.fromJson(v));
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

class StateData {
  String id;
  String text;
  var other;

  StateData({this.id, this.text, this.other});

  StateData.fromJson(Map<String, dynamic> json) {
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