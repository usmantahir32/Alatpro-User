import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/custom_large_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

class ContactUsPage extends StatelessWidget {
  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: Get.find<AuthController>().isLoading.value,
        child: Scaffold(
          appBar: const CustomAppBar(title: "Contact us"),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*5),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  CustomInputField(
                      controller: nameCont,
                      hintText: "Enter your name",
                      label: "Name"),
                  CustomInputField(
                      controller: phoneCont,
                      hintText: "Enter your phone",
                      label: "Phone"),
                  CustomInputField(
                      controller: emailCont,
                      hintText: "Enter your email",
                      label: "Email"),
                  CustomLargeInputField(
                      controller: message,
                      hintText: "Enter your message",
                      label: "Message"),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  CustomButton(
                      onTap: () {
                        if (nameCont.text.isNotEmpty &&
                            emailCont.text.isNotEmpty &&
                            message.text.isNotEmpty &&
                            phoneCont.text.isNotEmpty) {
                          DataBase()
                              .contactUS(nameCont.text, phoneCont.text,
                                  emailCont.text, message.text)
                              .then((value) {
                            nameCont.clear();
                            phoneCont.clear();
                            emailCont.clear();
                            message.clear();
                          });
                        } else {
                          Get.snackbar("Please try again",
                              "Please fill all required information",
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white);
                        }
                      },
                      text: "Submit")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
