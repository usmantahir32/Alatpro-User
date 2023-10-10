import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/services/firebase_api.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/dialogs/choose%20source/choose_source.dart';

class UserPhoto extends StatelessWidget {
  final authCont = Get.find<AuthController>();
  final cont = Get.find<ButtonsController>();
  Future onImgSelected(ImageSource source) async {
    //FOR SELECTING IMAGES AND SHOWING ON UI
    //Picking from the files

    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: source);
    Get.back();
    if (image != null) {
      final croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: ColorsConstant.kPrimaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          compressQuality: 70,
          compressFormat: ImageCompressFormat.jpg,
          aspectRatio: const CropAspectRatio(ratioX: 0.5, ratioY: 0.5),
          aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);

      croppedImage != null
          ? cont.pickedImagePath.value = croppedImage.path
          : cont.pickedImagePath.value = image.path;
      print("Image picked ${cont.pickedImagePath.value}");

      authCont.isLoading.value = true;
      FirebaseApi.onImageUploaded(File(cont.pickedImagePath.value))
          .then((value) {
        DataBase().onImageUpdate(cont.imgURL.value);
      });
    } else {
      Get.snackbar("Please try again", "Image was not selected :(",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Obx(
            () => Container(
              height: SizeConfig.heightMultiplier * 13,
              width: SizeConfig.widthMultiplier * 26,
              decoration: BoxDecoration(
                  color: ColorsConstant.kPrimaryColor,
                  border:
                      Border.all(color: ColorsConstant.kPrimaryColor, width: 5),
                  image: DecorationImage(
                      image: NetworkImage(authCont.userInfo.image ?? ""),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle),
            ),
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 1,
            right: SizeConfig.widthMultiplier * 1,
            child: GestureDetector(
              onTap: () => Get.dialog(ChooseSourceDialog(
                  onGalleryPress: () => onImgSelected(ImageSource.gallery),
                  onCameraPress: () => onImgSelected(ImageSource.camera),)),
              child: CircleAvatar(
                radius: SizeConfig.widthMultiplier * 3.5,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.black,
                  size: 17,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
