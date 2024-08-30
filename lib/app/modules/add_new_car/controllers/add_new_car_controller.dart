import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/car_provider.dart';

class AddNewCarController extends GetxController {
  bool getCarBrandsLoading = false;
  void changeGetCarBrandsLoading(bool value) {
    getCarBrandsLoading = value;
    update([GetBuildersIdsConstants.addNewCarBrandsList]);
  }

  List<CarBrandModel> allCarBrandsList = [];
  List<CarBrandModel> resultCarBrandsList = [];
  void changeCarBrandsList(List<CarBrandModel> value) {
    resultCarBrandsList = value;
    update([GetBuildersIdsConstants.addNewCarBrandsList]);
  }

  Future<void> getCarBrandsList() async {
    changeCarBrandsList([]);
    await CarProvider()
        .getCarsBrandsList(
      onLoading: () => changeGetCarBrandsLoading(true),
      onFinal: () => changeGetCarBrandsLoading(false),
    )
        .then((value) {
      if (value != null) {
        allCarBrandsList = value;
        changeCarBrandsList(value);
      }
    });
  }

  void searchInCarBrandsList(String value) {
    if (value.isEmpty) {
      changeCarBrandsList(allCarBrandsList);
    } else {
      changeCarBrandsList(allCarBrandsList
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList());
    }
  }

  int? selectedCarBrandId;
  void changeSelectedCarBrandId(int? value) {
    selectedCarBrandId = value;
    update([GetBuildersIdsConstants.addNewCarBrandsList]);
  }

  final GlobalKey<FormState> addNewCarFormKey = GlobalKey<FormState>();

  final FocusNode carBrandFocusNode = FocusNode();
  final FocusNode carModelFocusNode = FocusNode();
  final FocusNode platNumberFocusNode = FocusNode();

  final TextEditingController carBrandController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController plateNumberController = TextEditingController();

  List<String> colorsList = [
    "#FFFFFF",
    //grey
    "#808080",
    //blue
    "#0000FF",
    //red
    "#FF0000",
    //yellow
    "#FFFF00",
    //green
    "#008000",
    //pink
    "#FFC0CB",
    //black
    "#000000",
  ];

  String? selectedColor;
  void changeSelectedColor(String value) {
    selectedColor = value;
    update([GetBuildersIdsConstants.addNewCarColorsList]);
  }

  bool addNewCarLoading = false;
  void changeAddNewCarLoading(bool value) {
    addNewCarLoading = value;
    update([GetBuildersIdsConstants.addNewCarButton]);
  }

  Future<void> addNewCar() async {
    if (addNewCarLoading) return;
    if (!addNewCarFormKey.currentState!.validate()) return;
    if (selectedColor == null) {
      ToastComponent.showErrorToast(Get.context!,
          text: StringsAssetsConstants.selectCarColorValidationText);
      return;
    }
    await CarProvider()
        .addNewCar(
      brandId: selectedCarBrandId,
      model: carModelController.text,
      color: selectedColor!.replaceAll('#', ''),
      numberPlate: plateNumberController.text,
      onLoading: () => changeAddNewCarLoading(true),
      onFinal: () => changeAddNewCarLoading(false),
    )
        .then((value) {
      if (value != null) {
      } else {}
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
