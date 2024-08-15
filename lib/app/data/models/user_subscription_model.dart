class UserSubscriptionModel {
  int? id;
  int? branchId;
  String? startDate;
  String? endDate;
  int? remainingWashes;
  int? total;

  UserSubscriptionModel(
      {this.id,
      this.branchId,
      this.startDate,
      this.endDate,
      this.remainingWashes,
      this.total});

  UserSubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    remainingWashes = json['remaining_washes'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['remaining_washes'] = this.remainingWashes;
    data['total'] = this.total;
    return data;
  }
}
