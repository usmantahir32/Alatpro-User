class SortModel {
  String sortType;
  SortModel({required this.sortType});
}

List<SortModel> sortList = [
  SortModel(sortType: "recent"),
  SortModel(sortType: "pricewise"),
  SortModel(sortType: "yearwise"),
];
