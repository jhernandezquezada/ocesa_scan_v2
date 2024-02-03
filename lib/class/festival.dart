class Festival {
  final int id;
  final String name;

  Festival({required this.id, required this.name});

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      id: json['ID'],
      name: json['festival'],
    );
  }
}
