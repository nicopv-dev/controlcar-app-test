class Pokemon {
  final String id;
  final String name;
  final String image;
  bool captured;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    this.captured = false,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      captured: json['captured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  static List<Pokemon> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Pokemon.fromJson(json)).toList();
  }

  void setCaptured(bool captured) {
    captured = captured;
  }
}
