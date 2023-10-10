import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/show_loading.dart';

class PDFviewer extends StatefulWidget {
  const PDFviewer({Key? key, required this.pdfPath}) : super(key: key);
  final String pdfPath;

  @override
  State<PDFviewer> createState() => _PDFviewerState();
}

class _PDFviewerState extends State<PDFviewer> {
   final buttonCont = Get.find<ButtonsController>();
    final authCont = Get.find<AuthController>();
  
    Future<void> uploadPDF() async {
      authCont.isLoading.value=true;
      final path = 'files/${buttonCont.pdfPath.value}';
      final file = File(buttonCont.pdfPath.value);
      final ref = FirebaseStorage.instance.ref().child(path);

      final snapshot = await ref.putFile(file).whenComplete(() => {});
      buttonCont.pdfURL.value = await snapshot.ref.getDownloadURL();
      authCont.isLoading.value=false;

    }
    @override
  void dispose() {
    super.dispose();
   Future.delayed(Duration.zero,(){
     if(buttonCont.pdfURL.value==""){
      buttonCont.pdfPath.value="";
    }
   });
  }
  @override
  Widget build(BuildContext context) {
   
    

    return Obx(
     ()=> ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsConstant.kPrimaryColor,
              elevation: 0,
              title: Text(
                "PDF view",
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.2,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: ()=>uploadPDF().then((val)=>Get.back()),
                    child: Text(
                      "Done",
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2.2,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ))
              ],
            ),
            body: PdfView(path: widget.pdfPath)),
      ),
    );
  }
}
