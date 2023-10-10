import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:services_finder/models/products_model.dart';
import 'package:services_finder/services/database.dart';

class FavouriteController extends GetxController{
   Rxn<List<ProductsModel>> products = Rxn<List<ProductsModel>>();
  List<ProductsModel> get getProducts => products.value ?? [];
  

  @override
  void onInit() {
    super.onInit();
    products.bindStream(DataBase().streamForFavouriteProducts());}
}