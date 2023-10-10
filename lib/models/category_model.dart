import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? id;
  String? name, image;
  List? subCategories;
  CategoryModel({this.name, this.image, this.subCategories, this.id});
  CategoryModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    name = doc["Category"];
    image = doc["ImageURL"];
    subCategories = doc["SubCategory"];
  }
}
