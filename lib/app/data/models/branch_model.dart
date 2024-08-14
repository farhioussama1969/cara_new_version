class BranchModel {
  int? id;
  String? name;
  String? moyasarPublishableApiKey;
  String? moyasarSecretKey;
  String? moyasarMerchantId;

  BranchModel(
      {this.id,
      this.name,
      this.moyasarPublishableApiKey,
      this.moyasarSecretKey,
      this.moyasarMerchantId});

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moyasarPublishableApiKey = json['moyasar_publishable_api_key'];
    moyasarSecretKey = json['moyasar_secret_key'];
    moyasarMerchantId = json['moyasar_merchant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['moyasar_publishable_api_key'] = this.moyasarPublishableApiKey;
    data['moyasar_secret_key'] = this.moyasarSecretKey;
    data['moyasar_merchant_id'] = this.moyasarMerchantId;
    return data;
  }
}
