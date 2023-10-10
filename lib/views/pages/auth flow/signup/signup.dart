import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/icons.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

class SignupPage extends StatelessWidget {
  TextEditingController emailCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();

  TextEditingController passCont = TextEditingController();
  TextEditingController confirmPassCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Obx(
      () => ShowLoading(
        inAsyncCall: controller.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 8,
                ),
                Center(
                    child: Image.asset(
                  IconsConstant.appIcon,
                  width: SizeConfig.widthMultiplier * 60,
                )),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 8,
                ),
                CustomInputField(
                  controller: nameCont,
                  hintText: "Lorem Ipsum",
                  label: "Full name",
                ),
                CustomInputField(
                  controller: emailCont,
                  hintText: "Lorem@gmail.com",
                  label: "Email address",
                ),
                CustomInputField(
                  controller: phoneCont,
                  hintText: "+12345678910",
                  label: "Phone number",
                ),
                CustomInputField(
                  controller: passCont,
                  hintText: "*********",
                  label: "Password",
                ),
                CustomInputField(
                  controller: confirmPassCont,
                  hintText: "*********",
                  label: "Confirm Password",
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                CustomButton(
                    onTap: () {
                      if (nameCont.text.isNotEmpty &&
                          emailCont.text.isNotEmpty &&
                          phoneCont.text.isNotEmpty &&
                          passCont.text.isNotEmpty &&
                          confirmPassCont.text.isNotEmpty) {
                        if (emailCont.text.isEmail) {
                          if (phoneCont.text.contains("+")) {
                            if (passCont.text == confirmPassCont.text) {
                              controller.isLoading.value = true;
                              controller.onSignup(nameCont.text, emailCont.text,
                                  phoneCont.text, passCont.text);
                            } else {
                              Get.snackbar(
                                  "Please try again", "Password didn't match",
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white);
                            }
                          } else {
                            Get.snackbar(
                                "Please try again", "Phone number incorrect",
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white);
                          }
                        } else {
                          Get.snackbar(
                              "Please try again", "Email address badly formatted",
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white);
                        }
                      } else {
                        Get.snackbar(
                            "Please try again", "Fill all required information",
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white);
                      }
                    },
                    text: "Register"),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.8,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600),
                    ).tr(),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 2),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontWeight: FontWeight.w700,
                          ),
                        ).tr(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
