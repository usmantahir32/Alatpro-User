import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/pdf%20viewer/pdf_viewer.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

import '../../widgets/custom_appbar.dart';

class VendorFormPage extends StatefulWidget {
  @override
  State<VendorFormPage> createState() => _VendorFormPageState();
}

class _VendorFormPageState extends State<VendorFormPage> {
  //TEXTEIDITING CONTROLLERS
  TextEditingController nameController = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController baseCity = TextEditingController();

  //CONTROLLER
  final buttonCont = Get.find<ButtonsController>();

  //ATTACH PDF METHOD
  void attachPDF() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) {
      Get.snackbar("Silakan coba lagi", "No File Selected",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } else {
      buttonCont.pdfPath.value = result.files.first.path!;
      Get.to(() => PDFviewer(pdfPath: buttonCont.pdfPath.value),
          transition: Transition.downToUp);
    }
  }

  @override
  void dispose() {
    super.dispose();
    buttonCont.pdfPath.value = "";
    buttonCont.pdfURL.value = "";
  }

  @override
  Widget build(BuildContext context) {
    print("URL ${buttonCont.pdfURL.value}");
    return Obx(
      () => ShowLoading(
        inAsyncCall: Get.find<AuthController>().isLoading.value,
        child: Scaffold(
            appBar: const CustomAppBar(title: "Vendor Form",),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomInputField(
                        controller: nameController,
                        hintText: "Enter your name",
                        label: "Name"),
                    CustomInputField(
                        controller: companyName,
                        hintText: "Enter your company name",
                        label: "Company Name"),
                    CustomInputField(
                        controller: position,
                        hintText: "Enter your position",
                        label: "Position"),
                    CustomInputField(
                        controller: email,
                        hintText: "Enter your email",
                        label: "Email"),
                    CustomInputField(
                        controller: phone,
                        hintText: "Enter your phone number",
                        label: "Phone"),
                    CustomInputField(
                        controller: baseCity,
                        hintText: "Enter your base city",
                        label: "City"),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buttonCont.pdfPath.value == ""
                                ? "Attach list of units (.pdf)"
                                : basename(buttonCont.pdfPath.value),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                              onPressed: () => attachPDF(),
                              icon: buttonCont.pdfPath.value == ""
                                  ? const Icon(Icons.add)
                                  : const Icon(Icons.edit))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 5,
                    ),
                    CustomButton(
                        onTap: () {
                          if (nameController.text.isNotEmpty &&
                              companyName.text.isNotEmpty &&
                              position.text.isNotEmpty &&
                              email.text.isNotEmpty &&
                              phone.text.isNotEmpty &&
                              baseCity.text.isNotEmpty) {
                           
                              DataBase().submitForm(
                                  nameController.text,
                                  companyName.text,
                                  position.text,
                                  email.text,
                                  phone.text,
                                  baseCity.text,
                                  buttonCont.pdfURL.value).then((value) {
                                    nameController.clear();
                                    companyName.clear();
                                    position.clear();
                                    email.clear();
                                    phone.clear();
                                    baseCity.clear();
                                    buttonCont.pdfPath.value="";
                                    buttonCont.pdfURL.value="";

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
            )),
      ),
    );
  }
}
