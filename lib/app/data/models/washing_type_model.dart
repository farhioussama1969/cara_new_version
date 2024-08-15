class WashingTypeModel {
  int? id;
  String? name;
  double? price;

  WashingTypeModel({this.id, this.name, this.price});

  WashingTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price =
        json['price'] != null ? double.parse(json['price'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
