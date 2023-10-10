import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/filter_controller.dart';
import 'package:services_finder/models/products_model.dart';

class SearchController extends GetxController {
  final filterCont = Get.find<FilterController>();
  final authCont = Get.find<AuthController>();
  RxBool isLoading=false.obs;
  RxString searchVal = "".obs;
  Rxn<List<ProductsModel>> searchData = Rxn<List<ProductsModel>>();
  @override
  void onInit() {
    super.onInit();
    searchData.value = [];
  }

  //SEARCH METHOD
  Future<void> getSearchData() async {
    isLoading.value = true;
    await FirebaseFirestore.instance
        .collection("Products")
        .where("Disable", isEqualTo: false)
        .where("searchKey", isGreaterThanOrEqualTo: searchVal.toLowerCase())
        .where("field")
        .where("Category",
            whereIn: filterCont.selectedCategories.isEmpty
                ? null
                : filterCont.selectedCategories.value)
       
        .get()
        .then((value) {
      searchData.value = [];

      if (filterCont.noFilter.value == true) {
        for (int i = 0; i < value.docs.length; i++) {
          searchData.value
              ?.add(ProductsModel.fromDocumentSnapshot(value.docs[i]));
        }
      } else {
        for (int i = 0; i < value.docs.length; i++) {
          print("SELECTED CATEGORIES ${filterCont.selectedCategories.length}");
          print("SELECTED BRANDS ${filterCont.selectedBrands.length}");
          print(
              "SELECTED CERTFICIATES ${filterCont.selectedCertificates.length}");

          // if(filterCont.selectedBrands.isNotEmpty && filterCont.selectedCategories.isNotEmpty && filterCont.selectedCertificates.isNotEmpty){
          if (filterCont.selectedBrands.contains(value.docs[i]["Brand"])) {
            if (value.docs[i]["Model"] >=
                    filterCont.fromYear.value &&
                value.docs[i]["Model"] <= filterCont.toYear.value) {
              searchData.value
                  ?.add(ProductsModel.fromDocumentSnapshot(value.docs[i]));
            }
          }


          if (filterCont.selectedCertificates
              .contains(value.docs[i]["Certificates"])) {
            if (value.docs[i]["Model"] >=
                    filterCont.fromYear.value &&
                value.docs[i]["Model"] <= filterCont.toYear.value) {
              searchData.value
                  ?.add(ProductsModel.fromDocumentSnapshot(value.docs[i]));
            }
          } else if (filterCont.selectedBrands.isEmpty &&
              filterCont.selectedCategories.isEmpty &&
              filterCont.selectedCertificates.isEmpty) {
            if (value.docs[i]["Model"] >=
                    filterCont.fromYear.value &&
                value.docs[i]["Model"] <= filterCont.toYear.value) {
              searchData.value
                  ?.add(ProductsModel.fromDocumentSnapshot(value.docs[i]));
            }
          }
        }
      }
    }).then((value) {
      if (filterCont.noFilter.value == true) {
        print("No Filter");
      } else {
        //DOING SORT
        if (filterCont.sortIndex.value == 1) {
          searchData.value?.sort(
              (a, b) => a.price![0]["price"].compareTo(b.price![0]["price"]));
        }
        if (filterCont.sortIndex.value == 2) {
          searchData.value?.sort((a, b) => a.model!.compareTo(b.model!));
        }
      }
    }).then((value) => isLoading.value = false);
  }
}
