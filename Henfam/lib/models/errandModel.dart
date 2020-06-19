enum ErrandType {
  ctownFood,
  campusFood,
  groceries,
  generalItems,
  other,
}

class ErrandModel {
  final String bigHenName;
  final String bigHenImage;
  final String timeFrame;
  final String location;
  final String destination;
  final ErrandType type;
  final int requestLimit;

  ErrandModel({
    this.bigHenName,
    this.bigHenImage,
    this.timeFrame,
    this.location,
    this.destination,
    this.type,
    this.requestLimit,
  });

  static List<ErrandModel> list = [
    ErrandModel(
      bigHenName: "Jessie",
      bigHenImage: "assets/henProfileIcon.png",
      timeFrame: "8pm-9pm",
      location: "Luna Street Food",
      destination: "Olin Library",
      type: ErrandType.ctownFood,
      requestLimit: 2,
    ),
  ];
}
