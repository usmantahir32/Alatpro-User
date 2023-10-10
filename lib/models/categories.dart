class CategoriesModel {
  String name, image;
  List<String> subCategories;
  CategoriesModel(
      {required this.image, required this.name, required this.subCategories});
}

List<CategoriesModel> categoriesList = [
  CategoriesModel(
      image: "assets/categories/crane.png",
      name: "Crane",
      subCategories: [
        "Mobile Crane",
        "Rough Terrain",
        "Crawler Crane",
        "Tower Crane",
        "Truck Crane",
        "All Cranes"
      ]),
  CategoriesModel(
      image: "assets/categories/excavator.png",
      name: "Excavator",
      subCategories: [
        "Crawler Excavator",
        "Wheel Excavator",
        "Amphibious Excavator",
        "Mini Excavator",
        "All Excavators"
      ]),
  CategoriesModel(
      image: "assets/categories/truck.png",
      name: "Truck",
      subCategories: [
        "Cargo Truck",
        "Box Truck",
        "Dump Truck",
        "Flatbed Truck",
        "Lowbed Truck",
        "Tank Truck",
        "Mixer Truck",
        "All Trucks",
      ]),
  CategoriesModel(
      image: "assets/categories/road-roller.png",
      name: "Vibro Roller",
      subCategories: ["Flat Drum Roller", "Padded Drum Roller", "All Rollers"]),
  CategoriesModel(
      image: "assets/categories/bulldozer.png",
      name: "Loader",
      subCategories: ["Standard Loader", "Backhoe", "All Loaders"]),
  CategoriesModel(
      image: "assets/categories/forklift.png",
      name: "Lift",
      subCategories: ["Forklift", "Boom Lift", "Scissor Lift", "All Lifts"]),
  CategoriesModel(
      image: "assets/categories/piling.png",
      name: "Pile Driver",
      subCategories: [
        "Diesel Hammer Pile Driver",
        "Hydraulic Static Pile Driver",
        "Vibro Hammer Pile Driver",
        "Mini Pile Hammer",
        "All Pile Drivers",
      ]),
  CategoriesModel(
      image: "assets/categories/electric-generator.png",
      name: "Generator",
      subCategories: [
        "Silent Diesel Generator",
        "Open Diesel Generator",
        "All Generators"
      ]),
  CategoriesModel(
      image: "assets/categories/grader.png",
      name: "Grader/Bulldozer",
      subCategories: ["Standard Bulldozer", "Road Grader", "All Bulldozers"]),
  CategoriesModel(
      image: "assets/categories/air-compressor.png",
      name: "Air Compressor",
      subCategories: [
        "Diesel Air Compressor",
        "Electric Air Compressor",
        "All Air Compressors"
      ]),
  CategoriesModel(
      image: "assets/categories/container.png",
      name: "Storage Container",
      subCategories: ["Dry Container", "Reefer Container", "All Containers"]),
  CategoriesModel(
      image: "assets/categories/pump.png",
      name: "Pump",
      subCategories: ["Concrete Pump", "All Pumps"]),
  CategoriesModel(
      image: "assets/categories/drilling-machine.png",
      name: "Drill",
      subCategories: ["Manual Drill Rig", "Crawler Pile Drill", "All Drills"]),
];
