import 'cartitem.dart';

class OrderModel {
  String? id;

  String? userName;
  String? email;
  List<CartItem> cartItem;
  String? countryName;
  String? cityName;
  String? addressDetails;
  String? promoCode;
  String? description;
  double? price;
  OrderModel(
      {required this.id,
      required this.cartItem,
      required this.countryName,
      required this.cityName,
      required this.addressDetails,
      required this.promoCode,
      required this.description,
      required this.price,
      required this.userName,
      required this.email});

  toMap() {
    return {
      "id": id,
      "cartItem": cartItem.map((item) => item.toMap()).toList(),
      "countryName": countryName,
      "cityName": cityName,
      "addressDetails": addressDetails,
      "promoCode": promoCode,
      "description": description,
      "price": price,
      "userName": userName,
      "email": email
    };
  }

  static fromMap(Map<String, dynamic> data) {
    return OrderModel(
        id: data['id'],
        cartItem: data['cartItem'],
        countryName: data['countryName'],
        cityName: data['cityName'],
        addressDetails: data['addressDetails'],
        promoCode: data['promoCode'],
        description: data['description'],
        price: data['price'],
        userName: data['userName'],
        email: data['email']);
  }
}
