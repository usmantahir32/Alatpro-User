import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  String? id,
      brand,
      category,
      
      location,
      model,
      name,
      operatorAllowance,
      adID,
      type,
      searchKey,
      whatsappNumber,description;
  bool? rentPerDay;
  List<dynamic>? images,subcategory,likedBy,price,certificates;
  ProductsModel(
      {this.brand,
      this.category,
      this.id,
      this.images,
      this.location,
      this.model,
      this.name,
      this.operatorAllowance,
      this.price,
      this.rentPerDay,
      this.subcategory,
      this.description,
      this.type,
      this.adID,
      this.likedBy,
      this.searchKey,
      this.whatsappNumber});
  ProductsModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    brand = doc["Brand"];
    category = doc["Category"];
    certificates = doc["Certificates"];
    images = doc["Images"];
    location = doc["Location"];
    model = doc["Model"].toString();
    name = doc["Name"];
    operatorAllowance = doc["OperatorAllowance"];
    price = doc["Prices"];
    subcategory = doc["Subcategory"];
    type = doc["Type"];
    whatsappNumber = doc["WhatsappNumber"];
    searchKey=doc["searchKey"];
    likedBy=doc["LikedBy"];
    description=doc["Description"];
    adID=doc["adID"];
  }
}
