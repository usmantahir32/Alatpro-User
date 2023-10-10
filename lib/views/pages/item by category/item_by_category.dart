import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/products_controller.dart';
import 'package:services_finder/models/products_model.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/item_tile.dart';
import 'package:services_finder/views/widgets/loading.dart';
import 'package:services_finder/views/widgets/no_data.dart';

class ItemsByCategoryPage extends StatefulWidget {
  const ItemsByCategoryPage(
      {Key? key,
      required this.subCategory,
      required this.mainCategory,
      required this.isLastIndex})
      : super(key: key);
  final String subCategory;
  final String mainCategory;
  final bool isLastIndex;
  @override
  State<ItemsByCategoryPage> createState() => _ItemsByCategoryPageState();
}

class _ItemsByCategoryPageState extends State<ItemsByCategoryPage> {
  List<ProductsModel> product = [];
  final authCont = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    print("Is Last Index ${widget.isLastIndex}");
    Future.delayed(Duration.zero, () => getItemByCategory());
  }

  getItemByCategory() async {
    authCont.isLoading.value = true;
    if (widget.isLastIndex) {
      await FirebaseFirestore.instance
          .collection("Products")
          .where("Disable", isEqualTo: false)
          .where("Category", isEqualTo: widget.mainCategory)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          product.add(ProductsModel.fromDocumentSnapshot(element));
        });
      }).then((value) => authCont.isLoading.value = false);
    } else {
      await FirebaseFirestore.instance
          .collection("Products")
          .where("Disable", isEqualTo: false)
          .where("Category", isEqualTo: widget.mainCategory)
          .where("Subcategory", arrayContains: widget.subCategory)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          product.add(ProductsModel.fromDocumentSnapshot(element));
        });
      }).then((value) => authCont.isLoading.value = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsConstant.kPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.subCategory,
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.2,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: authCont.isLoading.value
            ? LoadingWidget(height: SizeConfig.heightMultiplier * 80)
            : product.isEmpty
                ? NoDataWidget(
                    height: SizeConfig.heightMultiplier * 80,
                    text: "No Items Found!",
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: product.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.heightMultiplier * 2,
                                horizontal: SizeConfig.widthMultiplier * 5),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) => ItemTile(
                                uid: product[index].id ?? "",
                                isSearch: false,
                                product: product[index])),
                      )
                    ],
                  ),
      ),
    );
  }
}
