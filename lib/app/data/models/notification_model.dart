import 'order_model.dart';

class NotificationModel {
  int? id;
  OrderModel? order;
  String? title;
  String? message;
  bool? readable;
  String? createdAt;

  NotificationModel(
      {this.id,
      this.order,
      this.title,
      this.message,
      this.readable,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order =
        json['order'] != null ? new OrderModel.fromJson(json['order']) : null;
    title = json['title'];
    message = json['message'];
    readable = json['readable'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['readable'] = this.readable;
    data['created_at'] = this.createdAt;
    return data;
  }
}
