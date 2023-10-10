import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/models/products_model.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/item%20detail/item_detail.dart';
import 'package:intl/intl.dart';
import 'row_icon_info.dart';

class ItemTile extends StatefulWidget {
  const ItemTile(
      {Key? key,
      required this.uid,
      required this.isSearch,
      required this.product})
      : super(key: key);
  final String uid;
  final bool isSearch;
  final ProductsModel product;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    List<String> rentTypeNames = [
      tr("days"),
      tr("weekss"),
      tr("monthh"),
    ];
    final priceFormat = NumberFormat('#,000');
    final buttonCont = Get.find<ButtonsController>();
    return GestureDetector(
      onTap: () {
        Get.to(
            () => ItemDetailPage(
                  uid: widget.uid,
                  isSearch: widget.isSearch,
                ),
            transition: Transition.leftToRight);
      },
      child: Container(
        width: SizeConfig.widthMultiplier * 90,
        margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(10, 10),
                  blurRadius: 6)
            ],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300)),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 2,
            vertical: SizeConfig.heightMultiplier * 1),
        child: Stack(
          children: [
            Row(
              children: [
                //MACHINE IMAGE
                Container(
                  height: SizeConfig.heightMultiplier * 12,
                  width: SizeConfig.widthMultiplier * 27,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                          image: NetworkImage(widget.product.images?[0] ?? ""),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //NAME OF MACHINE
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 40,
                      child: Text(
                        widget.product.name ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.textMultiplier * 1.8),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.7,
                    ),
                    //MODEL OF MACHINE
                    RowIconInfo(
                      icon: Icons.calendar_month_outlined,
                      text: widget.product.model ?? "",
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.7,
                    ),
                    //LOCATION
                    RowIconInfo(
                      icon: Icons.location_on,
                      text: widget.product.location ?? "",
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    )
                  ],
                ),
              ],
            ),
            //PRICE
            Positioned(
              bottom: 0,
              right: SizeConfig.widthMultiplier * 1,
              child: Obx(
              ()=> Text(
                  "Rp ${priceFormat.format(int.parse(widget.product.price![Get.find<AuthController>().userInfo.rentTypeIndex ?? 0]["price"]))}/${rentTypeNames[Get.find<AuthController>().userInfo.rentTypeIndex ?? 0]}",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.8,
                      fontWeight: FontWeight.w700,
                      color: ColorsConstant.kPrimaryColor),
                ),
              ),
            ),
            Positioned(
              top: -SizeConfig.heightMultiplier * 1,
              right: 0,
              child: Obx(
                () => IconButton(
                    onPressed: () => likeQuery(),
                    icon: widget.product.likedBy!
                            .contains(Get.find<AuthController>().userss!.uid)
                        ? Icon(
                            Icons.favorite,
                            color: ColorsConstant.kPrimaryColor,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.grey.shade400,
                          )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> likeQuery() async {
    if (widget.product.likedBy!
        .contains(Get.find<AuthController>().userss!.uid)) {
      //UNLIKE
      widget.product.likedBy!.remove(Get.find<AuthController>().userss!.uid);
      await FirebaseFirestore.instance
          .collection("Products")
          .doc(widget.uid)
          .update({"LikedBy": widget.product.likedBy!});
    } else {
      //LIKE
      widget.product.likedBy!.add(Get.find<AuthController>().userss!.uid);
      await FirebaseFirestore.instance
          .collection("Products")
          .doc(widget.uid)
          .update({"LikedBy": widget.product.likedBy!});
    }
    setState(() {});
  }
}
