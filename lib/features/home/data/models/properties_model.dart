class PropertiesModel {
  int? id;
  int? userId;
  String? title;
  List<String>? imageUrls;
  String? slug;
  String? details;
  String? price;
  int? categoryId;
  int? size;
  bool? hasParking;
  bool? isForSale;
  bool? isForRent;
  int? placeId;
  int? bedrooms;
  int? bathrooms;
  bool? isSold;
  bool? hasPool;
  List<String>? appliances;
  String? yearBuilt;
  bool? AC;
  String? YTUrl;
  String? createdAt;
  String? updatedAt;
  Owner? owner;
  Category? category;
  Place? place;
  List<dynamic>? shares;

  PropertiesModel({
    this.id,
    this.userId,
    this.title,
    this.imageUrls,
    this.slug,
    this.details,
    this.price,
    this.categoryId,
    this.size,
    this.hasParking,
    this.isForSale,
    this.isForRent,
    this.placeId,
    this.bedrooms,
    this.bathrooms,
    this.isSold,
    this.hasPool,
    this.appliances,
    this.yearBuilt,
    this.AC,
    this.YTUrl,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.category,
    this.place,
    this.shares,
  });

  factory PropertiesModel.fromJson(Map<String, dynamic> json) {
    return PropertiesModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      imageUrls: json['imageUrls'] != null
          ? List<String>.from(json['imageUrls'])
          : null,
      slug: json['slug'],
      details: json['details'],
      price: json['price'],
      categoryId: json['categoryId'],
      size: json['size'],
      hasParking: json['hasParking'],
      isForSale: json['isForSale'],
      isForRent: json['isForRent'],
      placeId: json['placeId'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      isSold: json['isSold'],
      hasPool: json['hasPool'],
      appliances: json['appliances'] != null
          ? List<String>.from(json['appliances'])
          : null,
      yearBuilt: json['yearBuilt'],
      AC: json['AC'],
      YTUrl: json['YTUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      place: json['place'] != null ? Place.fromJson(json['place']) : null,
      shares:
          json['shares'] != null ? List<dynamic>.from(json['shares']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'owner': owner?.toJson(),
      'category': category?.toJson(),
      'place': place?.toJson(),
      'shares': shares,
    };
  }
}

class Owner {
  int? id;
  String? username;
  String? fullname;
  String? email;
  String? profileImg;

  Owner({
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.profileImg,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      profileImg: json['profileImg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'profileImg': profileImg,
    };
  }
}

class Category {
  int? id;
  String? name;
  String? details;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Place {
  int? id;
  String? name;
  Sector? sector;

  Place({
    this.id,
    this.name,
    this.sector,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      sector: json['sector'] != null ? Sector.fromJson(json['sector']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sector': sector?.toJson(),
    };
  }
}

class Sector {
  int? id;
  String? name;
  District? district;

  Sector({
    this.id,
    this.name,
    this.district,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'],
      name: json['name'],
      district:
          json['district'] != null ? District.fromJson(json['district']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'district': district?.toJson(),
    };
  }
}

class District {
  int? id;
  String? name;
  Province? province;

  District({
    this.id,
    this.name,
    this.province,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      province:
          json['province'] != null ? Province.fromJson(json['province']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'province': province?.toJson(),
    };
  }
}

class Province {
  int? id;
  String? name;

  Province({
    this.id,
    this.name,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
