import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

class ChangePasswordPage extends StatelessWidget {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: Get.find<AuthController>().isLoading.value,
        child: Scaffold(
          appBar: const CustomAppBar(title: "Change Password"),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                CustomInputField(
                    controller: oldPassword,
                    hintText: "Enter your old password",
                    label: "Old Password"),
                CustomInputField(
                    controller: newPassword,
                    hintText: "Enter your new password",
                    label: "New Password"),
                CustomInputField(
                    controller: confirmPassword,
                    hintText: "Enter your confirm new password",
                    label: "Confirm New Password"),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                CustomButton(
                    onTap: () => DataBase().onChangePassword(oldPassword.text,
                        newPassword.text, confirmPassword.text).then((value) {
                          oldPassword.clear();
                          newPassword.clear();
                          confirmPassword.clear();
                        }),
                    text: "Change Password")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
