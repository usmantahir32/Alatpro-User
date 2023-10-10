import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/models/categories.dart';
import 'package:services_finder/models/category_model.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/sub%20category/sub_category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.index,
    required this.category,
  }) : super(key: key);
  final int index;
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Get.to(() =>  SubCategoriesPage(
                        mainCategory: category.name??"",
                        subCategory: category.subCategories??[]
                      ),
                          transition: Transition.leftToRight),
      child: Container(
        height: SizeConfig.heightMultiplier * 14,
        width: SizeConfig.widthMultiplier * 24,
        margin: EdgeInsets.only(
            left: index == 0
                ? SizeConfig.widthMultiplier * 5
                : SizeConfig.widthMultiplier * 4),
        child: Column(
          children: [
            Container(
              height: SizeConfig.heightMultiplier * 11,
              width: SizeConfig.widthMultiplier * 24,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Image.network(
                  category.image??"",
                  height: SizeConfig.heightMultiplier * 7,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 0.7,
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 24,
              child: Text(
                category.name??"",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.5,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
