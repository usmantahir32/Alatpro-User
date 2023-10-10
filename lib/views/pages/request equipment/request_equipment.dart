import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/custom_large_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

class RequestEquipmentPage extends StatelessWidget {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController equipmentRequest = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
     ()=> ShowLoading(
        inAsyncCall: Get.find<AuthController>().isLoading.value,
        child: Scaffold(
          appBar: const CustomAppBar(title: "Request Equipment"),
          body: Center(
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
                    controller: emailCont,
                    hintText: "Enter your email",
                    label: "Email"),
                CustomLargeInputField(
                    controller: equipmentRequest,
                    hintText: "Equipments you would like to see on AlatPro",
                    label: "Equipments"),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                CustomButton(
                    onTap: () {
                      if (nameCont.text.isNotEmpty &&
                          emailCont.text.isNotEmpty &&
                          equipmentRequest.text.isNotEmpty) {
                        DataBase()
                            .requestEquipment(nameCont.text, emailCont.text,
                                equipmentRequest.text)
                            .then((value) {
                          nameCont.clear();
                          emailCont.clear();
                          equipmentRequest.clear();
                        });
                      } else {
                        Get.snackbar("Silakan coba lagi",
                            "Please Isi semua informasi yang diperlukan",
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
    );
  }
}
