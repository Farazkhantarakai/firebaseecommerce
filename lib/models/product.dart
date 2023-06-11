import 'package:get/get.dart';

class Product extends GetxController {
  int? id;
  String? branch;
  int? calories;
  String? category;
  int? deliveryTime;
  List? imageUrl;
  String? ingredients;
  int? price;
  double? rating;
  String? title;
  bool? isFavourite;
  Product(
      {required this.id,
      required this.branch,
      required this.calories,
      required this.category,
      required this.deliveryTime,
      required this.imageUrl,
      required this.ingredients,
      required this.price,
      required this.rating,
      required this.title,
      required this.isFavourite});

  toMap() {
    return {
      "id": id,
      "branch": branch,
      "calories": calories,
      "category": category,
      "deliveryTime": deliveryTime,
      "imageUrl": imageUrl,
      "ingredients": ingredients,
      "price": price,
      "rating": rating,
      "title": title
    };
  }

  static fromMap(Map<String, dynamic> data) {
    return Product(
        id: data['id'],
        branch: data['branch'],
        calories: data['calories'],
        category: data['category'],
        deliveryTime: data['deliveryTime'],
        imageUrl: data['imageUrl'],
        ingredients: data['ingredients'],
        price: data['price'],
        rating: data['rating'],
        title: data['title'],
        isFavourite: data['isFavourite']);
  }

  void makeFavourte() {
    isFavourite = !isFavourite!;
    update();
  }
}
