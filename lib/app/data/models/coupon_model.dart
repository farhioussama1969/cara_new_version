class CouponModel {
  int? couponId;
  double? couponDiscount;
  double? actualTotal;
  String? message;

  CouponModel(
      {this.actualTotal, this.couponDiscount, this.couponId, this.message});

  CouponModel.fromJson(Map<String, dynamic> json) {
    couponId = json["coupon_id"];
    couponDiscount = json["coupon_discount"] != null
        ? double.parse(json["coupon_discount"].toString())
        : null;
    actualTotal = json["actual_total"] != null
        ? double.parse(json["actual_total"].toString())
        : null;
    message = json["message"];
  }
}
