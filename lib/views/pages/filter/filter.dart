import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:services_finder/constants/colors.dart';
import 'package:services_finder/controllers/auth_controller.dart';
import 'package:services_finder/controllers/filter_controller.dart';
import 'package:services_finder/controllers/products_controller.dart';
import 'package:services_finder/controllers/search_controller.dart';
import 'package:services_finder/services/database.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/widgets/custom_buttons.dart';
import 'package:services_finder/views/widgets/show_loading.dart';
import '../../widgets/rent_type.dart';
import 'components/sort_type.dart';
import 'components/year_picker.dart' as yp;

import 'components/add_category.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final filterCont = Get.find<FilterController>();
  final productCont = Get.find<ProductsController>();
  final authCont = Get.find<AuthController>();
  String filterUID = "";
  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration.zero, () => getFilterData());
  }

  // Future<void> getFilterData() async {
  //   filterUID = "${authCont.userss!.uid}_filter";
  //   authCont.isLoading.value = true;
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(authCont.userss!.uid)
  //       .collection("Filter")
  //       .get()
  //       .then((value) {
  //     print(value.docs.length);
  //     if (value.docs.isNotEmpty) {
  //       FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(authCont.userss!.uid)
  //           .collection("Filter")
  //           .doc(filterUID)
  //           .get()
  //           .then((value) {
  //         filterCont.selectedBrands.value = value["Brands"];
  //         filterCont.fromYear.value = value["FromYear"];
  //         filterCont.toYear.value = value["ToYear"];
  //         filterCont.selectedCategories.value = value["Category"];
  //         filterCont.selectedCertificates.value = value["Certificates"];
  //         filterCont.sortIndex.value = value["SortIndex"];
  //       }).then((value) => authCont.isLoading.value = false);
  //     } else {
  //       authCont.isLoading.value = false;
  //     }
  //   });
  // }

  @override
  void dispose() {
    authCont.isLoading.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 10,
                      ),
                      Text(
                        "Filters",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.3,
                            fontWeight: FontWeight.w700),
                      ).tr(),
                      InkWell(
                        onTap: () => Get.back(),
                        child: CircleAvatar(
                          radius: SizeConfig.widthMultiplier * 4,
                          backgroundColor: Colors.grey.shade300,
                          child: Icon(
                            FeatherIcons.x,
                            color: Colors.grey.shade800,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  //SELECT BRAND
                  AddCategoryWidget(
                    list: filterCont.selectedBrands.value,
                    heading: "Brand",
                    onAdd: () {
                      BottomPicker(
                        items: [
                          for (int i = 0; i < productCont.brands.length; i++) ...[
                            Text(
                              productCont.brands[i],
                              style: const TextStyle(fontFamily: "OpenSans"),
                            ),
                          ]
                        ],
                        selectedItemIndex: 1,
          
                        title: tr("Brand"),
          
                        pickerTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: "OpenSans",
                            color: Colors.black),
                        // displayButtonIcon: false,
                        titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        onChange: (i) {
                          print(i);
                        },
                        onSubmit: (index) {
                          if (!filterCont.selectedBrands
                              .contains(productCont.brands[index])) {
                            filterCont.selectedBrands
                                .add(productCont.brands[index]);
                          }
                        },
                        displayButtonIcon: false,
                        buttonText:
                            "                      ${tr('Add Brand')}                       ",
                        buttonTextStyle: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        displaySubmitButton: true,
                        buttonSingleColor: ColorsConstant.kPrimaryColor,
                        bottomPickerTheme: BottomPickerTheme.plumPlate,
                        layoutOrientation: LayoutOrientation.ltr,
                      ).show(context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  //SELECT YEAR
                  Text(
                    "Year",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //FROM YEAR
                      Obx(
                        () => yp.YearPicker(
                          heading: "From",
                          subheading: filterCont.fromYear.value.toString(),
                          onCalendarTap: () {
                            BottomPicker(
                              items: [
                                for (int i = 0; i < 23; i++) ...[
                                  Text(
                                    i >= 10 ? "20$i" : "200$i",
                                    style:
                                        const TextStyle(fontFamily: "OpenSans"),
                                  ),
                                ]
                              ],
                              selectedItemIndex: 1,
          
                              title: tr("From Year"),
          
                              pickerTextStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: "OpenSans",
                                  color: Colors.black),
                              // displayButtonIcon: false,
                              titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              onChange: (i) {
                                print(i);
                              },
                              onSubmit: (index) {
                                if (filterCont.toYear.value >
                                    int.parse(
                                        index >= 10 ? "20$index" : "200$index")) {
                                  filterCont.fromYear.value = int.parse(
                                      index >= 10 ? "20$index" : "200$index");
                                } else {
                                  Get.snackbar(
                                      "Please try again", "Select correct date",
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white);
                                }
                              },
                              displayButtonIcon: false,
                              buttonText:
                                  "                      ${tr('Add Year')}                       ",
                              buttonTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                              displaySubmitButton: true,
                              buttonSingleColor: ColorsConstant.kPrimaryColor,
                              bottomPickerTheme: BottomPickerTheme.plumPlate,
                              layoutOrientation: LayoutOrientation.ltr,
                            ).show(context);
                          },
                        ),
                      ),
                      //TO YEAR
                      yp.YearPicker(
                        heading: "To",
                        subheading: filterCont.toYear.value.toString(),
                        onCalendarTap: () {
                          BottomPicker(
                            items: [
                              for (int i = 0; i < 23; i++) ...[
                                Text(
                                  i >= 10 ? "20$i" : "200$i",
                                  style: const TextStyle(fontFamily: "OpenSans"),
                                ),
                              ]
                            ],
                            selectedItemIndex: 1,
          
                            title:tr('To Year'),
          
                            pickerTextStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.textMultiplier * 2,
                                fontFamily: "OpenSans",
                                color: Colors.black),
                            // displayButtonIcon: false,
                            titleStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            onChange: (i) {
                              print(i);
                            },
                            onSubmit: (index) {
                              if (filterCont.fromYear.value <
                                  int.parse(
                                      index >= 10 ? "20$index" : "200$index")) {
                                filterCont.toYear.value = int.parse(
                                    index >= 10 ? "20$index" : "200$index");
                              } else {
                                Get.snackbar(
                                    "Please try again", "Select correct date",
                                    backgroundColor: Colors.redAccent,
                                    colorText: Colors.white);
                              }
                            },
                            displayButtonIcon: false,
                            buttonText:
                                "                      ${tr('Add Year')}                       ",
                            buttonTextStyle: const TextStyle(
                                fontWeight: FontWeight.w700, color: Colors.white),
                            displaySubmitButton: true,
                            buttonSingleColor: ColorsConstant.kPrimaryColor,
                            bottomPickerTheme: BottomPickerTheme.plumPlate,
                            layoutOrientation: LayoutOrientation.ltr,
                          ).show(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  //SELECT CATEGORY
                  AddCategoryWidget(
                    list: filterCont.selectedCategories.value,
                    heading: tr("Category"),
                    onAdd: () {
                      BottomPicker(
                        items: [
                          for (int i = 0;
                              i < productCont.categories.length;
                              i++) ...[
                            Text(
                              productCont.categories[i],
                              style: const TextStyle(fontFamily: "OpenSans"),
                            ),
                          ]
                        ],
                        selectedItemIndex: 1,
          
                        title: tr("Category"),
          
                        pickerTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: "OpenSans",
                            color: Colors.black),
                        // displayButtonIcon: false,
                        titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        onChange: (i) {
                          print(i);
                        },
                        onSubmit: (index) {
                          if (!filterCont.selectedCategories
                              .contains(productCont.categories[index])) {
                            filterCont.selectedCategories
                                .add(productCont.categories[index]);
                          }
                        },
                        displayButtonIcon: false,
                        buttonText:
                            "                      ${tr('Add Category')}                       ",
                        buttonTextStyle: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        displaySubmitButton: true,
                        buttonSingleColor: ColorsConstant.kPrimaryColor,
                        bottomPickerTheme: BottomPickerTheme.plumPlate,
                        layoutOrientation: LayoutOrientation.ltr,
                      ).show(context);
                    },
                  ),
          
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  //SELECT CERTIFICATE
                  AddCategoryWidget(
                    list: filterCont.selectedCertificates.value,
                    heading: tr("Certificate"),
                    onAdd: () {
                      BottomPicker(
                        items: [
                          for (int i = 0;
                              i < productCont.certificates.length;
                              i++) ...[
                            Text(
                              productCont.certificates[i],
                              style: const TextStyle(fontFamily: "OpenSans"),
                            ),
                          ]
                        ],
                        selectedItemIndex: 0,
          
                        title: tr("Certificate"),
          
                        pickerTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: "OpenSans",
                            color: Colors.black),
                        // displayButtonIcon: false,
                        titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        onChange: (i) {
                          print(i);
                        },
                        onSubmit: (index) {
                          if (!filterCont.selectedCertificates
                              .contains(productCont.certificates[index])) {
                            filterCont.selectedCertificates
                                .add(productCont.certificates[index]);
                          }
                        },
                        displayButtonIcon: false,
                        buttonText:
                            "                  ${tr('Add Certificate')}                           ",
                        buttonTextStyle: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                        displaySubmitButton: true,
                        buttonSingleColor: ColorsConstant.kPrimaryColor,
                        bottomPickerTheme: BottomPickerTheme.plumPlate,
                        layoutOrientation: LayoutOrientation.ltr,
                      ).show(context);
                    },
                  ),
          
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  //SELECT RENT
                  Text(
                    "Rent",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontWeight: FontWeight.w700),
                  ).tr(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  RentType(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  //SELECT SORT BY
                  Text(
                    "Sort",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontWeight: FontWeight.w700),
                  ).tr(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  SortType(),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  CustomButton(
                      onTap: () {
                        Get.back();
                        filterCont.noFilter.value=false;
                        Get.find<SearchController>().getSearchData();
                        // DataBase()
                        //   .addFilter(
                        //       filterCont.selectedBrands,
                        //       filterCont.fromYear.value,
                        //       filterCont.toYear.value,
                        //       filterCont.selectedCategories,
                        //       filterCont.selectedCertificates,
                        //       filterCont.sortIndex.value)
                        //   .then((value) => filterCont.getFilterData());
          
                      } ,
                      text: "Apply")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
