import 'package:flutter/cupertino.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';

class CarBrandCardComponent extends StatelessWidget {
  const CarBrandCardComponent(
      {super.key, required this.carBrand, required this.isSelected});

  final CarBrandModel carBrand;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
