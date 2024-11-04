class Category {
  final String? categoryId;
  final String? categoryName;
  final int? categoryNumber;
  final List<dynamic> feedback;

  Category({
    this.categoryId,
    this.categoryName,
    this.categoryNumber,
    required this.feedback,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['id'] as String?,
      categoryName: json['category_name'] as String?,
      categoryNumber: json['categoryNumber'] as int?,
      feedback:
          json['feedback'] != null ? List<dynamic>.from(json['feedback']) : [],
    );
  }
}
