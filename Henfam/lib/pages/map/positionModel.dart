class PositionModel {
  String name;
  double latitude;
  double longitude;

  PositionModel(this.name, this.latitude, this.longitude);

  static PositionModel restaurantPosition =
      PositionModel('Oishii Bowl', 42.441947, -76.485066);

  static List<PositionModel> mockPositionData = [
    PositionModel('Oishii Bowl', 42.441947, -76.485066),
    PositionModel('John', 42.447866, -76.484200),
    PositionModel('Lisa', 42.444806, -76.482617),
  ];
}
