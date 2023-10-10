import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/controllers/favourites_controller.dart';
import 'package:services_finder/controllers/filter_controller.dart';
import 'package:services_finder/controllers/products_controller.dart';
import 'package:services_finder/controllers/search_controller.dart';
import 'package:services_finder/views/pages/auth%20flow/login/login.dart';
import 'package:services_finder/views/pages/bottom%20nav%20bar/bottom_nav_bar.dart';
import '../controllers/auth_controller.dart';
import '../controllers/category_controller.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ButtonsController());
    Get.put(AuthController(),permanent: true);
    Get.put(ProductsController());
    Get.put(FilterController());
    Get.put(CategoryController());
    Get.put(SearchController());

    Future.delayed(Duration.zero,()=>Get.put(ProductsController()));
    return GetX<AuthController>(initState: (_) async {
      Get.put<AuthController>(AuthController());
    }, builder: (_) {
      if (Get.find<AuthController>().user != null) {
        _.getUser();
        return BottomNavBar();
      } else {
        return LoginPage();
      }
    });
  }
}
