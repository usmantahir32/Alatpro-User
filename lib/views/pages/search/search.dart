// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:get/get.dart';
// import 'package:services_finder/constants/colors.dart';
// import 'package:services_finder/controllers/auth_controller.dart';
// import 'package:services_finder/controllers/filter_controller.dart';
// import 'package:services_finder/models/products_model.dart';
// import 'package:services_finder/utils/size_config.dart';
// import 'package:services_finder/views/widgets/loading.dart';
// import 'package:services_finder/views/widgets/no_data.dart';

// import '../../widgets/item_tile.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final authCont = Get.find<AuthController>();
//   final filterCont = Get.find<FilterController>();
//   List<ProductsModel> searchData = [];
//   bool noFilter = false;
//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(
//         Duration.zero, () => filterCont.getFilterData().then((val) => getSearchData()));
//   }

//   Future<void> getSearchData() async {
//     authCont.isLoading.value = true;
//     await FirebaseFirestore.instance
//         .collection("Products")
//         .where("searchKey",
//             isGreaterThanOrEqualTo: searchCont.text.toLowerCase())
//         .get()
//         .then((value) {
//       searchData = [];
//       if (noFilter == true) {
//         for (int i = 0; i < value.docs.length; i++) {
//           searchData.add(ProductsModel.fromDocumentSnapshot(value.docs[i]));
//         }
//       } else {
//         for (int i = 0; i < value.docs.length; i++) {
//           if (filterCont.selectedBrands.contains(value.docs[i]["Brand"]) ||
//               filterCont.selectedCategories
//                   .contains(value.docs[i]["Category"]) ||
//               filterCont.selectedCertificates
//                   .contains(value.docs[i]["Certificates"])) {
//             searchData.add(ProductsModel.fromDocumentSnapshot(value.docs[i]));
//           }
//         }
//       }
//     }).then((value) {
//       if (noFilter == true) {
//         print("No Filter");
//       } else {
//         //DOING SORT
//         if (filterCont.sortIndex.value == 1) {
//           searchData.sort((a, b) => a.price!.compareTo(b.price!));
//         }
//         if (filterCont.sortIndex.value == 2) {
//           searchData.sort((a, b) => a.model!.compareTo(b.model!));
//         }
//       }
//     }).then((value) => authCont.isLoading.value = false);
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Column(
//           children: [
//             Container(
//               height: SizeConfig.heightMultiplier * 10,
//               width: SizeConfig.widthMultiplier * 100,
//               color: ColorsConstant.kPrimaryColor,
//               padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
//               child: Row(
//                 children: [
//                   const BackButton(
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: SizeConfig.widthMultiplier * 2,
//                   ),
//                   Container(
//                     height: SizeConfig.heightMultiplier * 5,
//                     width: SizeConfig.widthMultiplier * 80,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                         horizontal: SizeConfig.widthMultiplier * 4),
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: TextField(
//                           controller: searchCont,
//                           maxLength: 28,
//                           onChanged: (val) {
//                             getSearchData();
//                             setState(() {});
//                           },
//                           scrollPadding: const EdgeInsets.all(0),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             counterText: "",
//                             hintText: "Search",
//                             hintStyle: TextStyle(
//                                 fontSize: SizeConfig.textMultiplier * 1.8,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey),
//                           ),
//                         )),
//                         Icon(
//                           FeatherIcons.search,
//                           color: Colors.grey.shade400,
//                           size: 20,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }
