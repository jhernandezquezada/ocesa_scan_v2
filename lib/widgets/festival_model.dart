class FestivalModel {
  final int id;
  final String name;

  FestivalModel({required this.id, required this.name});

  factory FestivalModel.fromJson(Map<String, dynamic> json) {
    return FestivalModel(
      id: json['ID'],
      name: json['festival'],
    );
  }
}
// TODO Implement this library.