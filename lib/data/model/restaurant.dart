class Restaurant {
  Restaurant({
    required this.error,
    required this.message,
    this.count,
    required this.restaurants,
  });

  final bool error;
  final String message;
  final int? count;
  final List<RestaurantList> restaurants;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: List<RestaurantList>.from((json["restaurants"] as List)
          .map((e) => RestaurantList.fromJson(e))));

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantList {
  RestaurantList({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String pictureId;
  final double rating;

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

class RestaurantDetail {
  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  final bool error;
  final String message;
  final RestaurantDetailList restaurant;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
          error: json["error"],
          message: json["message"],
          restaurant: RestaurantDetailList.fromJson(json["restaurant"]));

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

class RestaurantDetailList {
  RestaurantDetailList({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final double rating;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;

  factory RestaurantDetailList.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailList(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
        address: json["address"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "rating": rating,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.name,
  });

  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Category> foods;
  final List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class RestaurantSearch {
  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<RestaurantList> restaurants;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
          error: json["error"],
          founded: json["founded"],
          restaurants: List<RestaurantList>.from((json["restaurants"] as List)
              .map((e) => RestaurantList.fromJson(e))));
}

class RestaurantReview {
  RestaurantReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  factory RestaurantReview.fromJson(Map<String, dynamic> json) =>
      RestaurantReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            (json["customerReviews"] as List)
                .map((e) => RestaurantDetailList.fromJson(e))),
      );
}
