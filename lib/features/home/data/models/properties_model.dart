import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PropertiesModel {
  int id;
  int userId;
  String title;
  List<String> imageUrls;
  String slug;
  String details;
  int price;
  int categoryId;
  int? size;
  bool hasParking;
  bool isForSale;
  bool isForRent;
  int placeId;
  int bedrooms;
  int bathrooms;
  bool isSold;
  bool hasPool;
  List<String> appliances;
  String yearBuilt;
  bool AC;
  String YTUrl;
  String createdAt;
  String? updatedAt;
  PropertiesModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrls,
    required this.slug,
    required this.details,
    required this.price,
    required this.categoryId,
    this.size,
    required this.hasParking,
    required this.isForSale,
    required this.isForRent,
    required this.placeId,
    required this.bedrooms,
    required this.bathrooms,
    required this.isSold,
    required this.hasPool,
    required this.appliances,
    required this.yearBuilt,
    required this.AC,
    required this.YTUrl,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'imageUrls': imageUrls,
      'slug': slug,
      'details': details,
      'price': price,
      'categoryId': categoryId,
      'size': size,
      'hasParking': hasParking,
      'isForSale': isForSale,
      'isForRent': isForRent,
      'placeId': placeId,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'isSold': isSold,
      'hasPool': hasPool,
      'appliances': appliances,
      'yearBuilt': yearBuilt,
      'AC': AC,
      'YTUrl': YTUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PropertiesModel.fromMap(Map<String, dynamic> map) {
    return PropertiesModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: map['title'] as String,
      imageUrls: List<String>.from((map['imageUrls'] as List<String>)),
      slug: map['slug'] as String,
      details: map['details'] as String,
      price: map['price'] as int,
      categoryId: map['categoryId'] as int,
      size: map['size'] != null ? map['size'] as int : null,
      hasParking: map['hasParking'] as bool,
      isForSale: map['isForSale'] as bool,
      isForRent: map['isForRent'] as bool,
      placeId: map['placeId'] as int,
      bedrooms: map['bedrooms'] as int,
      bathrooms: map['bathrooms'] as int,
      isSold: map['isSold'] as bool,
      hasPool: map['hasPool'] as bool,
      appliances: List<String>.from((map['appliances'] as List<String>)),
      yearBuilt: map['yearBuilt'] as String,
      AC: map['AC'] as bool,
      YTUrl: map['YTUrl'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertiesModel.fromJson(String source) => PropertiesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
  
        // "owner": {
        //     "id": 1,
        //     "username": "johndoe",
        //     "fullname": "John Doe",
        //     "email": "johndoe@example.com",
        //     "profileImg": "https://tura-storage-s3.s3.us-east-1.amazonaws.com/users/user.png"
        // },
        // "category": {
        //     "id": 1,
        //     "name": "Residential House",
        //     "details": "A property designed for people to live in, typically detached or semi-detached.",
        //     "createdAt": "2025-01-31T22:20:23.837Z",
        //     "updatedAt": "2025-01-31T22:20:23.837Z"
        // },
        // "place": {
        //     "id": 1,
        //     "name": "Near the golf field",
        //     "sector": {
        //         "id": 1,
        //         "name": "Kacyiru",
        //         "district": {
        //             "id": 1,
        //             "name": "Gasabo",
        //             "province": {
        //                 "id": 1,
        //                 "name": "Kigali"
        //             }
        //         }
        //     }
        // },
        // "shares": []