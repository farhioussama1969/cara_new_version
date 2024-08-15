class GiftModel {
  int? id;
  String? title;
  String? description;
  double? amount;
  String? image;
  int? numberWashes;

  GiftModel(
      {this.id,
      this.title,
      this.description,
      this.amount,
      this.image,
      this.numberWashes});

  GiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    amount = double.parse(json['amount'].toString());
    image = json['image'];
    numberWashes = json['number_washes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['image'] = this.image;
    return data;
  }
}
