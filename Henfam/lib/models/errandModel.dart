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

  static final gettingFoodFromCtown = [
    ErrandModel(
      bigHenName: "Jessie",
      bigHenImage: "assets/henProfileIcon.png",
      timeFrame: "8pm-9pm",
      location: "Luna Street Food",
      destination: "Olin Library",
      type: ErrandType.ctownFood,
      requestLimit: 2,
    ),
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
  static final otherErrands = [
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

  static List<Map<String, Object>> list = [
    {
      "caption": "Getting Food from Collegetown",
      "errands": gettingFoodFromCtown,
    },
    {
      "caption": "Other Errands",
      "errands": otherErrands,
    },
  ];
}
