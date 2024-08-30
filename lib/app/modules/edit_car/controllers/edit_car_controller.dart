import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/car_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/my_cars/controllers/my_cars_controller.dart';

class EditCarController extends GetxController {
  CarModel? carModel;

  bool getCarBrandsLoading = false;
  void changeGetCarBrandsLoading(bool value) {
    getCarBrandsLoading = value;
    update([GetBuildersIdsConstants.editCarBrandsList]);
  }

  List<CarBrandModel> allCarBrandsList = [];
  List<CarBrandModel> resultCarBrandsList = [];
  void changeCarBrandsList(List<CarBrandModel> value) {
    resultCarBrandsList = value;
    update([GetBuildersIdsConstants.editCarBrandsList]);
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
    update([GetBuildersIdsConstants.editCarBrandsList]);
  }

  final GlobalKey<FormState> updateCarFormKey = GlobalKey<FormState>();

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
    update([GetBuildersIdsConstants.editCarColorsList]);
  }

  bool updateCarLoading = false;
  void changeUpdateCarLoading(bool value) {
    updateCarLoading = value;
    update([GetBuildersIdsConstants.updateCarButton]);
  }

  void filCarData() {
    carBrandController.text = carModel?.brand?.name ?? '';
    carModelController.text = carModel?.model ?? '';
    plateNumberController.text = carModel?.numberPlate ?? '';
    selectedColor = '#${carModel?.color}';
    selectedCarBrandId = carModel?.brand?.id;
  }

  Future<void> updateCar() async {
    if (updateCarLoading) return;
    if (!updateCarFormKey.currentState!.validate()) return;
    if (selectedColor == null) {
      ToastComponent.showErrorToast(Get.context!,
          text: StringsAssetsConstants.selectCarColorValidationText);
      return;
    }
    await CarProvider()
        .updateCar(
      carId: carModel?.id,
      brandId: selectedCarBrandId,
      model: carModelController.text,
      color: selectedColor!.replaceAll('#', ''),
      numberPlate: plateNumberController.text,
      onLoading: () => changeUpdateCarLoading(true),
      onFinal: () => changeUpdateCarLoading(false),
    )
        .then((value) {
      if (value != null) {
        Get.back();
        Get.find<MyCarsController>().refreshMyCars();
        ToastComponent.showSuccessToast(Get.context!,
            text: StringsAssetsConstants.carUpdatedSuccessfully);
      } else {
        ToastComponent.showErrorToast(Get.context!,
            text: StringsAssetsConstants.generalErrorMessage);
      }
    });
  }

  bool deleteCarLoading = false;
  void changeDeleteCarLoading(bool value) {
    deleteCarLoading = value;
    update([GetBuildersIdsConstants.deleteCarButton]);
  }

  Future<void> deleteCar() async {
    if (deleteCarLoading) return;
    await CarProvider()
        .deleteCar(
      carId: carModel?.id,
      onLoading: () => changeDeleteCarLoading(true),
      onFinal: () => changeDeleteCarLoading(false),
    )
        .then((value) {
      if (value != null) {
        Get.back();
        Get.back();
        Get.find<MyCarsController>().refreshMyCars();
        ToastComponent.showSuccessToast(Get.context!,
            text: StringsAssetsConstants.carDeletedSuccessfully);
      } else {
        ToastComponent.showErrorToast(Get.context!,
            text: StringsAssetsConstants.generalErrorMessage);
      }
    });
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      carModel = Get.arguments['car'];
      filCarData();
    }
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
