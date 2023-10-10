import 'package:get/state_manager.dart';

class ButtonsController extends GetxController {
  RxInt bnbSelectedIndex = 0.obs;
  RxInt adsIndex = 0.obs;
  RxList favoriteRecommendedTileIndex = [].obs;
  RxBool isSearch=false.obs;
  
  //FOR FILTER
  RxInt selectedRentType = 0.obs;
  RxInt selectedSortType = 0.obs;

  //FOR ITEM DETAIL
  RxInt itemImageIndex = 0.obs;
  
  //FOR PROFILE
  RxString imgURL = "".obs;
  RxString pickedImagePath="".obs;

  //FOR VENDOR
  RxString pdfPath="".obs;
  RxString pdfURL="".obs;
  
  

 
}
