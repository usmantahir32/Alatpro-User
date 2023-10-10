import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/pdf%20viewer/pdf_viewer.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/custom_inputfield.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

import '../../widgets/custom_appbar.dart';

class CareerPage extends StatefulWidget {
  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  //TEXTEIDITING CONTROLLERS
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  //CONTROLLER
  final buttonCont = Get.find<ButtonsController>();

  //ATTACH PDF METHOD
  void attachPDF() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) {
      Get.snackbar("Please try again", "No File Selected",
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
            appBar: const CustomAppBar(
              title: "Career",
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  CustomInputField(
                      controller: name,
                      hintText: "Enter your name",
                      label: "Name"),
                  CustomInputField(
                      controller: email,
                      hintText: "Enter your email",
                      label: "Email"),
                  CustomInputField(
                      controller: phone,
                      hintText: "Enter your phone number",
                      label: "Phone"),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          buttonCont.pdfPath.value == ""
                              ? "Attach CV"
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
                        if (name.text.isNotEmpty &&
                            email.text.isNotEmpty &&
                            phone.text.isNotEmpty) {
                          if (buttonCont.pdfURL.isNotEmpty &&
                              buttonCont.pdfPath.isNotEmpty) {
                            DataBase()
                                .addCareer(name.text, phone.text, email.text,
                                    buttonCont.pdfURL.value)
                                .then((value) {
                              buttonCont.pdfPath.value = "";
                              buttonCont.pdfURL.value = "";
                              name.clear();
                              email.clear();
                              phone.clear();
                            });
                          } else {
                            Get.snackbar("Please try again",
                                "PDF was not uploaded or selected",
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white);
                          }
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
            )),
      ),
    );
  }
}
