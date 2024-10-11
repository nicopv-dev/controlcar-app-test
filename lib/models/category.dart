class Category {
  final String name;
  final String url;

  Category({required this.name, required this.url});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
