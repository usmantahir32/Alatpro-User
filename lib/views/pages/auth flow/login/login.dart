import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/icons.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/auth%20flow/forgot%20password/forgot_password.dart';
import 'package:services_finder/views/pages/auth%20flow/signup/signup.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

import 'components/social_button.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Obx(
      () => ShowLoading(
        inAsyncCall: controller.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5),
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
                    controller: emailCont,
                    hintText: "Lorem@gmail.com",
                    label: "Email",
                  ),
                  CustomInputField(
                    controller: passCont,
                    hintText: "*********",
                    label: "Password",
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () =>Get.to(()=>ForgotPasswordPage(),transition: Transition.rightToLeft),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.textMultiplier * 1.8),
                      ).tr(),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 6,
                  ),
                  CustomButton(
                    onTap: () {
                      if (emailCont.text.isNotEmpty && passCont.text.isNotEmpty) {
                        if (emailCont.text.isEmail) {
                          controller.isLoading.value = true;
                          controller.onSignIn(emailCont.text, passCont.text);
                        } else {
                          Get.snackbar(
                              tr("Please try again"), tr("Email address badly formatted"),
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white);
                        }
                      } else {
                        Get.snackbar(
                            tr("Please try again"), tr("Fill all required information"),
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white);
                      }
                    },
                    text: "Login",
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  SocialButton(
                    onTap: () =>controller.signInWithGoogle(),
                    isFacebook: false,
                  ),
                  SocialButton(
                    onTap: () =>controller.onFacebookSignin(),
                    isFacebook: true,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 10,
                  ),
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                      ).tr(),
                      InkWell(
                        onTap: () {
                          Get.to(() => SignupPage(),
                              transition: Transition.leftToRight);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 2),
                          child: Text(
                            "Register",
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
      ),
    );
  }
  
}
