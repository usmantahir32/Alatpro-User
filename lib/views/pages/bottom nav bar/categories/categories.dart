import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/category_controller.dart';
import 'package:services_finder/models/categories.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/sub%20category/sub_category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryCont = Get.find<CategoryController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstant.kPrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Categories",
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.2,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ).tr(),
      ),
      body: Obx(
        ()=> ListView.builder(
            itemCount: categoryCont.getCategories.length,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.only(
                left: SizeConfig.widthMultiplier * 5,
                right: SizeConfig.widthMultiplier * 5,
                bottom: SizeConfig.heightMultiplier * 15,
                top: SizeConfig.heightMultiplier * 2),
            shrinkWrap: true,
            itemBuilder: (_, index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() =>  SubCategoriesPage(
                        mainCategory: categoryCont.getCategories[index].name??"",
                        subCategory: categoryCont.getCategories[index].subCategories??[]
                      ),
                          transition: Transition.leftToRight),
                      child: Container(
                        height: SizeConfig.heightMultiplier * 10,
                        width: SizeConfig.widthMultiplier * 90,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 9,
                              width: SizeConfig.widthMultiplier * 20,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Image.network(
                                  categoryCont.getCategories[index].image??"",
                                  height: SizeConfig.heightMultiplier * 6,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 6,
                            ),
                            Text(
                              categoryCont.getCategories[index].name??"",
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.2,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade800,
                              size: 18,
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 1,
                            )
                          ],
                        ),
                      ),
                    ),
                    index == categoriesList.length - 1
                        ? const SizedBox()
                        : Divider(
                            color: Colors.grey,
                            height: SizeConfig.heightMultiplier * 2,
                          )
                  ],
                )),
      ),
    );
  }
}
