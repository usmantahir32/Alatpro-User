import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/favourites_controller.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/item_tile.dart';
import 'package:services_finder/views/widgets/no_data.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCont = Get.put(FavouriteController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstant.kPrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Favorites",
          style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 2.2,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ).tr(),
      ),
      body: Obx(
        () => productCont.getProducts.isEmpty
            ? NoDataWidget(
              height: SizeConfig.heightMultiplier*75,
              text: "You have not added any favorites",
              
            )
            : ListView.builder(
                itemCount: productCont.getProducts.length,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.only(
                    left: SizeConfig.widthMultiplier * 5,
                    right: SizeConfig.widthMultiplier * 5,
                    bottom: SizeConfig.heightMultiplier * 15,
                    top: SizeConfig.heightMultiplier * 2),
                shrinkWrap: true,
                itemBuilder: (_, index) => ItemTile(
                      uid: productCont.getProducts[index].id ?? "",
                      isSearch: false,
                      product: productCont.getProducts[index],
                    )),
      ),
    );
  }
}
