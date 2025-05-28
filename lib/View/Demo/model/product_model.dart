import 'dart:convert';

class ProductModel {
  final int? id;
  final String? title;
  final String? slug;
  final String? photo;
  final Category? category;
  final double? price;
  final double? buyPrice;
  final double? rentPrice;
  final int? quantity;
  final double? weight;
  final String? description;
  final String? photoUrl;

  ProductModel({
    this.id,
    this.title,
    this.slug,
    this.photo,
    this.category,
    this.price,
    this.buyPrice,
    this.rentPrice,
    this.quantity,
    this.weight,
    this.description,
    this.photoUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      photo: json['photo'] as String?,
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      price: json['price'] != null ? (json['price'] as num?)?.toDouble() : null,
      buyPrice: json['buy_price'] != null ? (json['buy_price'] as num?)?.toDouble() : null,
      rentPrice: json['rent_price'] != null ? (json['rent_price'] as num?)?.toDouble() : null,
      quantity: json['quantity'] as int?,
      weight: json['weight'] != null ? (json['weight'] as num?)?.toDouble() : null,
      description: json['description'] as String?,
      photoUrl: json['photo_url'] as String?,
    );
  }
}

class Category {
  final int? id;
  final String? title;
  final String? photoUrl;

  Category({this.id, this.title, this.photoUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      title: json['title'] as String?,
      photoUrl: json['photo_url'] as String?,
    );
  }
}