import 'package:equatable/equatable.dart';

import 'package:flutterapiecommerce/features/products/domain/model/reviews.dart';
import 'package:hive/hive.dart';
//flutter pub run build_runner build --delete-conflicting-outputs
part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final double rating;
  @HiveField(6)
  final String thumbnail;
  @HiveField(7)
  final List<String> images;
  @HiveField(8)
  final List<Reviews> reviews;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.images,
    required this.reviews,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    rating,
    thumbnail,
    images,
    reviews,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail,
      'images': images,
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      thumbnail: map['thumbnail'] ?? '',
      images: List<String>.from((map['images'] ?? [])),
      reviews: List<Reviews>.from(
        (map['reviews'] as List? ?? []).map<Reviews>(
          (x) => Reviews.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
