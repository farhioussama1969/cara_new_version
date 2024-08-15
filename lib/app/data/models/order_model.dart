import 'package:solvodev_mobile_structure/app/data/models/user_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';

import 'car_model.dart';

class OrderModel {
  int? id;
  UserModel? user;
  CarModel? car;
  WashingTypeModel? washingType;
  String? date;
  String? time;
  double? price;
  String? paymentMethod;
  String? status;
  double? rate;
  String? note;

  OrderModel(
      {this.id,
      this.user,
      this.car,
      this.washingType,
      this.date,
      this.time,
      this.price,
      this.paymentMethod,
      this.status,
      this.rate,
      this.note});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    car = json['car'] != null ? new CarModel.fromJson(json['car']) : null;
    washingType = json['washingType'] != null
        ? new WashingTypeModel.fromJson(json['washingType'])
        : null;
    date = json['date'];
    time = json['time'];
    price = double.parse(json['price'].toString());
    paymentMethod = json['payment_method'];
    status = json['status'];
    rate = json['rate'] != null ? double.parse(json['rate'].toString()) : 0;
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.washingType != null) {
      data['washingType'] = this.washingType!.toJson();
    }
    data['date'] = this.date;
    data['time'] = this.time;
    data['price'] = this.price;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['rate'] = this.rate;
    data['note'] = this.note;
    return data;
  }
}
