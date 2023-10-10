import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:services_finder/models/products_model.dart';
import 'package:services_finder/services/database.dart';

class ProductsController extends GetxController {
  Rxn<List<ProductsModel>> products = Rxn<List<ProductsModel>>();
  List<ProductsModel> get getProducts => products.value ?? [];
  RxList brands = [].obs;
  RxList categories = [].obs;
  RxList certificates = [].obs;

  @override
  void onInit() {
    super.onInit();
    products.bindStream(DataBase().streamForProducts());
    gettingBrands();
    gettingCategories();
    gettingCertificates();
  }

  //GETTING BRANDS
  Future<void> gettingBrands() async {
    await FirebaseFirestore.instance.collection("Brands").get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        brands.add(value.docs[i].get("Name"));
      }
    }).then((value) => print("Brands Added"));
  }

  //GETTING CATEGORIES
  Future<void> gettingCategories() async {
    await FirebaseFirestore.instance
        .collection("Categories")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        categories.add(value.docs[i].get("Category"));
      }
    }).then((value) => print("Categries Added"));
  }

  //GETTING CERTIFICATES
  Future<void> gettingCertificates() async {
    await FirebaseFirestore.instance
        .collection("Certificates")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        certificates.add(value.docs[i].get("Name"));
      }
    }).then((value) => print("Certificates Added"));
  }
}
