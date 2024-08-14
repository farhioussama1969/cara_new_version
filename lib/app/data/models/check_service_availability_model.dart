import 'package:solvodev_mobile_structure/app/data/models/branch_model.dart';

class CheckServiceAvailabilityModel {
  BranchModel? branch;
  bool? availability;

  CheckServiceAvailabilityModel({
    this.branch,
    this.availability,
  });

  CheckServiceAvailabilityModel.fromJson(Map<String, dynamic> json) {
    availability = json['data'];
    if (json['cityService'] != null) {
      branch = BranchModel.fromJson(json['cityService']['branch']);
    }
  }
}
