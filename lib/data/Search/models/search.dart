class Search {
  final String title;
  final String description;
  final double price;
  final List<String> images;
  final double rate;
  final double discount;
  final int stock;
  final List<Map<String, String>> reviews;
  Search(
      {required this.title,
      required this.discount,
      required this.price,
      required this.images,
      required this.stock,
      required this.description,
      required this.reviews,
      required this.rate});
  factory Search.fromJson(Map<String, dynamic> json) {
    List<dynamic> rawReviews = json['reviews'] ?? [];
    List<Map<String, String>> reviews =
        rawReviews.map<Map<String, String>>((review) {
      return {
        'user': review['user']?.toString() ?? '',
        'comment': review['comment']?.toString() ?? '',
      };
    }).toList();

    return Search(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? <String>[],
      reviews: reviews,
      stock: json['stock'] as int? ?? 0,
      rate: (json['rating'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
