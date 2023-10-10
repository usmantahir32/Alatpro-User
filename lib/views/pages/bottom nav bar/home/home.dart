import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/controllers/category_controller.dart';
import 'package:services_finder/controllers/filter_controller.dart';
import 'package:services_finder/controllers/products_controller.dart';
import 'package:services_finder/controllers/search_controller.dart';
import 'package:services_finder/models/products_model.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/item_tile.dart';
import 'package:services_finder/views/widgets/no_data.dart';
import '../../../widgets/loading.dart';
import 'components/category_tile.dart';
import 'components/home_ads.dart';
import 'components/upper_container.dart';

class HomePage extends StatelessWidget {
  final categoryCont = Get.find<CategoryController>();
  final productCont = Get.find<ProductsController>();
  final buttonCont = Get.find<ButtonsController>();
  final authCont = Get.find<AuthController>();
  final filterCont = Get.find<FilterController>();
  final searchCont = Get.find<SearchController>();

  TextEditingController searchTextCont = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    print("No Filter ${filterCont.noFilter.value}");
    return Scaffold(
      backgroundColor: ColorsConstant.kPrimaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: SizeConfig.heightMultiplier * 25,
            backgroundColor: ColorsConstant.kPrimaryColor,
            floating: false,
            pinned: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: HomeUpperContainer(
                cont: searchTextCont,
                onChange: (val) {
                  if (val.isEmpty) {
                    buttonCont.isSearch.value = false;
                  } else {
                    buttonCont.isSearch.value = true;
                  }
                  searchCont.searchVal.value=val;
                  searchCont.getSearchData();
                  print("This is val ${searchCont.searchVal.value}");
                },
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buttonCont.isSearch.value
                        ? const SizedBox()
                        : const HomeAdsWidget(),
                    buttonCont.isSearch.value
                        ? const SizedBox()
                        : SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),

                    ///CATEGORIES
                    buttonCont.isSearch.value
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.widthMultiplier * 5),
                            child: Row(
                              children: [
                                Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: SizeConfig.textMultiplier * 2),
                                ).tr(),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.find<ButtonsController>()
                                        .bnbSelectedIndex
                                        .value = 1;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 5),
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: ColorsConstant.kPrimaryColor,
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.5),
                                    ).tr(),
                                  ),
                                )
                              ],
                            ),
                          ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    //CATEGORIES TILES
                    buttonCont.isSearch.value
                        ? const SizedBox()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            child: Obx(
                              () => Row(
                                children: [
                                  ...List.generate(
                                      categoryCont.getCategories.length,
                                      (index) => CategoryTile(
                                            index: index,
                                            category: categoryCont
                                                .getCategories[index],
                                          ))
                                ],
                              ),
                            ),
                          ),
                    //RECOMMENDATIONS
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 5,
                            vertical: SizeConfig.heightMultiplier * 2),
                        child: Text(
                          buttonCont.isSearch.value
                              ? "Search Results"
                              : "Recommendations",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.textMultiplier * 2),
                        ).tr(),
                      ),
                    ),
                    Obx(
                      () => buttonCont.isSearch.value
                          ?
                          //SEARCH RESULTS
                          searchCont.isLoading.value
                              ? LoadingWidget(
                                  height: SizeConfig.heightMultiplier * 40)
                              : searchCont.searchData.value!.isEmpty
                                  ? NoDataWidget(
                                      height: SizeConfig.heightMultiplier * 30,
                                      text: "No Search Results",
                                    )
                                  : ListView.builder(
                                      itemCount: searchCont.searchData.value!.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier * 2,
                                          horizontal:
                                              SizeConfig.widthMultiplier * 5),
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) => ItemTile(
                                            uid: searchCont.searchData.value![index].id ?? "",
                                            isSearch: true,
                                            product: searchCont.searchData.value![index],
                                          ))
                          :
                          //RECOMMENDATIONS
                          ListView.builder(
                              itemCount: productCont.getProducts.length,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 5),
                              shrinkWrap: true,
                              itemBuilder: (_, index) => ItemTile(
                                    uid:
                                        productCont.getProducts[index].id ?? "",
                                    isSearch: false,
                                    product: productCont.getProducts[index],
                                  )),
                    ),
                    SizedBox(
                      height: buttonCont.isSearch.value
                          ? searchCont.searchData.value!.length > 0 || searchCont.searchData.value!.isEmpty
                              ? SizeConfig.heightMultiplier * 40
                              : searchCont.searchData.value!.length > 1
                                  ? SizeConfig.heightMultiplier * 20
                                  : SizeConfig.heightMultiplier * 12
                          : SizeConfig.heightMultiplier * 12,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
