import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/buttons_controller.dart';
import 'package:services_finder/models/products_model.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/loading.dart';
import 'package:services_finder/views/widgets/rent_type.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/bottom_whatsapp_buttons.dart';
import 'components/item_images.dart';
import 'components/row_info.dart';
import 'components/row_list_info.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({Key? key, required this.uid, required this.isSearch})
      : super(key: key);
  final String uid;
  final bool isSearch;
  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final buttonCont = Get.find<ButtonsController>();
  final authCont = Get.find<AuthController>();
  ProductsModel product = ProductsModel();
  bool liked = false;
  List likedBy = [];
  List prices = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => getProductData());
  }

  getProductData() async {
    authCont.isLoading.value = true;
    await FirebaseFirestore.instance
        .collection("Products")
        .doc(widget.uid)
        .get()
        .then((value) {
      likedBy = value["LikedBy"];
      liked = likedBy.contains(Get.find<AuthController>().userss!.uid)
          ? true
          : false;
      prices = [
        value.get("Prices")[0]["price"],
        value.get("Prices")[1]["price"],
        value.get("Prices")[2]["price"],
      ];
      product = ProductsModel.fromDocumentSnapshot(value);
    }).then((value) => authCont.isLoading.value = false);
  }

  @override
  void dispose() {
    super.dispose();
    authCont.isLoading.value = false;
    buttonCont.selectedRentType.value = 0;
  }

  openwhatsapp(String whatsapp, String msg) async {
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=$msg";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
        await launchUrl(Uri.parse(whatappURL_ios));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURl_android))) {
        await launchUrl(Uri.parse(whatsappURl_android));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp not installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat('#,000');
    return Obx(
      () => SafeArea(
        child: Container(
          height: SizeConfig.heightMultiplier * 100,
          width: SizeConfig.widthMultiplier * 100,
          color: Colors.white,
          child: authCont.isLoading.value
              ? widget.isSearch
                  ? const SizedBox()
                  : LoadingWidget(height: SizeConfig.heightMultiplier * 90)
              : Scaffold(
                  bottomSheet: BottomAppBar(
                    child: BottomWhatsappButton(
                      onTap: () {
                        openwhatsapp(product.whatsappNumber ?? "",
                            "Item Name: ${product.name}\nAd ID: ${product.adID}\n\nYour message: ");
                      },
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemImages(
                            images: product.images ?? [],
                            buttonCont: buttonCont),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //NAME AND PRICE
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 60,
                                        child: Text(
                                          product.name ?? "",
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.heightMultiplier *
                                                      2.8,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 0.7,
                                      ),
                                      Text(
                                        buttonCont.selectedRentType.value == 0
                                            ? "Rp ${priceFormat.format(int.parse(prices[0]))}/${tr("days")}"
                                            : buttonCont.selectedRentType
                                                        .value ==
                                                    1
                                                ? "Rp ${priceFormat.format(int.parse(prices[1]))}/${tr("weekss")}"
                                                : "Rp ${priceFormat.format(int.parse(prices[2]))}/${tr("monthh")}",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.3,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                ColorsConstant.kPrimaryColor),
                                      )
                                    ],
                                  ),
                                  // LIKE AND SHARE BUTTONS
                                  const Spacer(),
                                  InkWell(
                                      onTap: () async {
                                        if (liked == true) {
                                          liked = false;
                                          likedBy.remove(
                                              Get.find<AuthController>()
                                                  .userss!
                                                  .uid);
                                          await FirebaseFirestore.instance
                                              .collection("Products")
                                              .doc(widget.uid)
                                              .update({"LikedBy": likedBy});
                                        } else {
                                          liked = true;
                                          likedBy.add(Get.find<AuthController>()
                                              .userss!
                                              .uid);
                                          await FirebaseFirestore.instance
                                              .collection("Products")
                                              .doc(widget.uid)
                                              .update({"LikedBy": likedBy});
                                        }
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.widthMultiplier * 5,
                                            top: SizeConfig.heightMultiplier *
                                                0.5),
                                        child: Icon(
                                            liked
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: liked
                                                ? Colors.red
                                                : Colors.grey.shade500,
                                            size:
                                                SizeConfig.widthMultiplier * 8),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        String shareData =
                                            "${product.name}\n\nImages: ${product.images}\n\nPrice: ${product.price} Rp /day\nOperator Allowance: ${product.operatorAllowance} Rp /day\n\nBrand: ${product.brand}\nType: ${product.type}\nYear: ${product.model}\nCertificates: ${product.certificates}\nLocation: ${product.location}\n\nDescription:\n${product.description}";
                                        Share.share(shareData);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.widthMultiplier * 5,
                                            top: SizeConfig.heightMultiplier *
                                                0.8),
                                        child: Icon(Icons.share,
                                            color: Colors.blue.shade700,
                                            size:
                                                SizeConfig.widthMultiplier * 7),
                                      )),
                                ],
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                height: SizeConfig.heightMultiplier * 5,
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    right: SizeConfig.widthMultiplier * 10),
                                child: RentType(),
                              ),
                              Divider(
                                color: Colors.grey.shade500,
                                height: SizeConfig.heightMultiplier * 4,
                              ),
                              //OPERATOR FOOD ALLOWANCE
                              Text(
                                "Operator Food Allowance",
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.9,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsConstant.kPrimaryColor),
                              ).tr(),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 0.5,
                              ),
                              Text(
                                product.operatorAllowance == "-"
                                    ? "-"
                                    : "Rp ${priceFormat.format(int.parse(product.operatorAllowance!))}/${tr('day')}",
                                style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade500,
                                height: SizeConfig.heightMultiplier * 4,
                              ),
                              Text(
                                "Specifications",
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.9,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsConstant.kPrimaryColor),
                              ).tr(),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.5,
                              ),
                              RowInfo(
                                title: "Brand",
                                subtitle: product.brand ?? "",
                              ),
                              RowInfo(
                                title: "Type",
                                subtitle: product.type ?? "",
                              ),
                              RowInfo(
                                title: "Year",
                                subtitle: product.model ?? "",
                              ),
                              RowListInfo(
                                title: "Certificates",
                                list: product.certificates ?? [],
                              ),
                              RowInfo(
                                title: "Location",
                                subtitle: product.location ?? "",
                              ),
                              Divider(
                                color: Colors.grey.shade500,
                                height: SizeConfig.heightMultiplier * 4,
                              ),
                              Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.9,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsConstant.kPrimaryColor),
                              ).tr(),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              Text(product.description ?? ""),
                              Divider(
                                color: Colors.grey.shade500,
                                height: SizeConfig.heightMultiplier * 4,
                              ),
                              RowInfo(title: "Ad ID", subtitle: product.adID!)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 12,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
