class FreeWashingConfigModel {
  int? washingCount;
  int? washingCountAllow;
  int? freeOrder;

  FreeWashingConfigModel(
      {this.washingCount, this.washingCountAllow, this.freeOrder});

  FreeWashingConfigModel.fromJson(Map<String, dynamic> json) {
    washingCount = json['washing_count'];
    washingCountAllow = json['washing_count_allow'];
    freeOrder = json['free_order'];
  }
}
