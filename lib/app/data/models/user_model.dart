class UserModel {
  int? id;
  String? username;
  String? phone;
  String? status;
  double? wallet;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.username,
      this.phone,
      this.status,
      this.lastLogin,
      this.wallet,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];

    phone = json['phone'];
    wallet =
        json['wallet'] != null ? double.parse(json['wallet'].toString()) : 0.0;

    status = json['status'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;

    data['phone'] = this.phone;
    data['wallet'] = this.wallet;

    data['status'] = this.status;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
