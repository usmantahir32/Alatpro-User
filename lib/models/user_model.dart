import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id, fullName, email, phone, password,image,whichLogin;
  int? rentTypeIndex;
  UserModel({this.email, this.fullName, this.id, this.password,this.whichLogin, this.phone,this.image});
  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    fullName = doc["FullName"];
    email = doc["Email"];
    phone = doc["Phone"];
    password = doc["Password"];
    image=doc["Image"];
    whichLogin=doc["WhichLogin"];
    rentTypeIndex=doc["RentTypeIndex"];
  }
}
