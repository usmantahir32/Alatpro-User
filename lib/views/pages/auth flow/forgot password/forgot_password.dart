import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailCont = TextEditingController();
    return Obx(
      () => ShowLoading(
        inAsyncCall: Get.find<AuthController>().isLoading.value,
        child: Scaffold(
          appBar: CustomAppBar(title: 'Forgot Password'),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                CustomInputField(
                    controller: emailCont,
                    hintText: 'Enter your email',
                    label: 'Email'),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                CustomButton(
                    onTap: () {
                      if (emailCont.text.isNotEmpty) {
                        Get.find<AuthController>().isLoading.value = true;
                        Get.find<AuthController>()
                            .onForgotPassword(emailCont.text)
                            .then((val) {
                              Get.find<AuthController>()
                                .isLoading
                                .value = false;
                                emailCont.clear();
                            });
                      } else {
                        Get.snackbar(tr("Please try again"),
                            tr('Please fill all required information'),
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white);
                      }
                    },
                    text: 'Send Reset Link')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
