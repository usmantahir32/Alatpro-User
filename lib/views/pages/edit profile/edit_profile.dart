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

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final authCont = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    userName.text = authCont.userInfo.fullName ?? "";
    phoneNumber.text = authCont.userInfo.phone ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: Get.find<AuthController>().isLoading.value,
        child: Scaffold(
          appBar: const CustomAppBar(title: "Edit Profile"),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                CustomInputField(
                    controller: userName,
                    hintText: "Enter your full name",
                    label: "Full Name"),
                CustomInputField(
                    controller: phoneNumber,
                    hintText: "Enter your phone number",
                    label: "Phone"),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                CustomButton(
                    onTap: () {
                      if (userName.text.isNotEmpty &&
                          phoneNumber.text.isNotEmpty) {
                        DataBase().editProfile(userName.text, phoneNumber.text).then((value) => authCont.getUser());
                      } else {
                        Get.snackbar("Please try again",
                            "Please fill all required information",
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white);
                      }
                    },
                    text: "Update")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
