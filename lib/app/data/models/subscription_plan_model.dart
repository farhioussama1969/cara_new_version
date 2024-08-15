class SubscriptionPlanModel {
  int? id;
  int? branchId;
  double? price;
  String? image;

  SubscriptionPlanModel({this.id, this.branchId, this.price, this.image});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    price =
        json['price'] != null ? double.parse(json['price'].toString()) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
