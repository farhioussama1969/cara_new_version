class AppVersionCheckerModel {
  String? message;
  bool? priority;
  String? link;

  AppVersionCheckerModel({this.message, this.priority, this.link});

  AppVersionCheckerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    priority = json['data']['priority'];
    link = json['data']['link'];
  }
}
