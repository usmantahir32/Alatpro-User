import 'package:get/get.dart';
import 'package:services_finder/models/category_model.dart';
import 'package:services_finder/services/database.dart';

class CategoryController extends GetxController{
  Rxn<List<CategoryModel>> category = Rxn<List<CategoryModel>>();
  List<CategoryModel> get getCategories => category.value??[];
  @override
  void onInit() {
    super.onInit();
    category.bindStream(DataBase().streamForCategories());
  }
}