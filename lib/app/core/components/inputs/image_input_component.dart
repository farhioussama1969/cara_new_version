import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class ImageInputComponent extends StatefulWidget {
  Function(File)? saveImage;
  File? imageFile;
  Widget? child;
  bool? cropImage;
  bool? isRectangularImage;
  bool? disable;

  ImageInputComponent({super.key, this.saveImage, this.imageFile, this.child, this.cropImage, this.isRectangularImage, this.disable});

  @override
  _ImageInputComponentState createState() => _ImageInputComponentState();
}

class _ImageInputComponentState extends State<ImageInputComponent> {
  @override
  Widget build(BuildContext context) {
    Widget imagePlace = GestureDetector(
        onTap: () {
          if (widget.disable != true) _showChooses(context);
        },
        child: widget.child);
    return imagePlace;
  }

  _showChooses(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: MainColors.transparentColor,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.r, sigmaY: 3.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                  //height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () => _getImage(ImageSource.camera, widget.isRectangularImage),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 15.r),
                          decoration: BoxDecoration(
                              color: MainColors.backgroundColor(context),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: MainColors.shadowColor(context)!.withOpacity(0.3),
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                  blurRadius: 15.r,
                                ),
                              ]),
                          // height: 120.r,
                          width: 150.r,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImagesAssetsConstants.cameraImage,
                                width: 60.r,
                              ),
                              SizedBox(height: 5.r),
                              Center(
                                child: Text(
                                  StringsAssetsConstants.camera,
                                  style: TextStyles.mediumBodyTextStyle(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () => _getImage(ImageSource.gallery, widget.isRectangularImage),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 15.r),
                          decoration: BoxDecoration(
                              color: MainColors.backgroundColor(context),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: MainColors.shadowColor(context)!.withOpacity(0.3),
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                  blurRadius: 15.r,
                                ),
                              ]),
                          // height: 120.r,
                          width: 150.r,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImagesAssetsConstants.galleryImage,
                                width: 60.r,
                              ),
                              SizedBox(height: 5.r),
                              Center(
                                child: Text(
                                  StringsAssetsConstants.gallery,
                                  style: TextStyles.mediumBodyTextStyle(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        });
  }

  _getImage(ImageSource source, bool? isRectangularImage) async {
    ImagePicker picker = ImagePicker();
    if (source == ImageSource.gallery) {
      XFile? details = await picker.pickImage(source: source);
      widget.imageFile = File(details!.path);
      widget.saveImage!(File(details.path));
    } else {
      XFile? details = await picker.pickImage(source: source);
      widget.imageFile = File(details!.path);
      widget.saveImage!(File(details.path));
    }
  }
}

enum ImageSources { camera, image }
