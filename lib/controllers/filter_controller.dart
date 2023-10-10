import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/auth_controller.dart';

class FilterController extends GetxController{
  RxList selectedBrands=[].obs;
  RxList selectedCategories=[].obs;
  RxList selectedCertificates=[].obs;
  RxInt fromYear=2000.obs;
  RxInt toYear=2022.obs;
  RxBool noFilter=true.obs;
  // RxInt ren
  RxInt sortIndex=0.obs;
  // Future<void> getFilterData() async {
  //   final authCont = Get.find<AuthController>();
  //   authCont.isLoading.value = true;

  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(authCont.userss!.uid)
  //       .collection("Filter")
  //       .get()
  //       .then((value) {
  //     print(value.docs.length);
  //     if (value.docs.isNotEmpty) {
  //       FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(authCont.userss!.uid)
  //           .collection("Filter")
  //           .doc("${Get.find<AuthController>().userss!.uid}_filter")
  //           .get()
  //           .then((value) {
  //        selectedBrands.value = value["Brands"];
  //        fromYear.value = value["FromYear"];
  //        toYear.value = value["ToYear"];
  //        selectedCategories.value = value["Category"];
  //        selectedCertificates.value = value["Certificates"];
  //        sortIndex.value = value["SortIndex"];
  //       });
  //     } else {
  //       noFilter.value = true;
  //     }
  //   }).then((value) => authCont.isLoading.value=false);
  // }
}