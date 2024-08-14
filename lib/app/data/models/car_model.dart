import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';

class CarModel {
  int? id;
  CarBrandModel? brand;
  String? model;
  String? color;
  String? numberPlate;

  CarModel({this.id, this.brand, this.model, this.color, this.numberPlate});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'] != null
        ? new CarBrandModel.fromJson(json['brand'])
        : null;
    model = json['model'];
    color = json['color'];
    numberPlate = json['number_plate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['model'] = this.model;
    data['color'] = this.color;
    data['number_plate'] = this.numberPlate;
    return data;
  }
}
