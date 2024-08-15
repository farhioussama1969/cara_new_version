class GiftCouponModel {
  int? id;
  String? title;
  String? code;
  String? startDate;
  String? endDate;
  int? numberOfUses;
  int? numberWashes;

  GiftCouponModel(
      {this.id,
      this.title,
      this.code,
      this.startDate,
      this.endDate,
      this.numberOfUses});

  GiftCouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    numberOfUses = json['number_of_uses'];
    numberWashes = json['number_washes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['number_of_uses'] = this.numberOfUses;
    return data;
  }
}
