import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/products_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/item%20by%20category/item_by_category.dart';
import 'package:services_finder/views/widgets/custom_appbar.dart';
import 'package:services_finder/views/widgets/no_data.dart';

import '../../widgets/row_button.dart';

class SubCategoriesPage extends StatefulWidget {
  const SubCategoriesPage(
      {Key? key, required this.subCategory, required this.mainCategory})
      : super(key: key);
  final List subCategory;
  final String mainCategory;

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  @override
  void dispose() {
    super.dispose();
    // Get.find<ProductsController>().products.bindStream(DataBase().streamForProducts("Recommendations","null","null"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.mainCategory),
      body: Column(
        children: [
          ListView.builder(
              itemCount: widget.subCategory.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 3),
              itemBuilder: (_, index) => RowButton(
                    text: widget.subCategory[index],
                    onTap: () => Get.to(
                        () => ItemsByCategoryPage(
                            isLastIndex: index == widget.subCategory.length - 1
                                ? true
                                : false,
                            subCategory: widget.subCategory[index],
                            mainCategory: widget.mainCategory),
                        transition: Transition.leftToRight),
                  ))
        ],
      ),
    );
  }
}
