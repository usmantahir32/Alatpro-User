class RentModel {
  String rentType;
  RentModel({required this.rentType});
}

List<RentModel> rentList = [
  RentModel(rentType: "day"),
  RentModel(rentType: "weeks"),
  RentModel(rentType: "month"),
];
