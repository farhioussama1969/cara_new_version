class WorkingTimesModel {
  String? day;
  TimeModel? times;

  WorkingTimesModel({this.day, this.times});

  WorkingTimesModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    times = json['times'] != null ? new TimeModel.fromJson(json['times']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.times != null) {
      data['times'] = this.times!.toJson();
    }
    return data;
  }
}

class TimeModel {
  String? value;
  String? status;

  TimeModel({this.value, this.status});

  TimeModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['status'] = this.status;
    return data;
  }
}
