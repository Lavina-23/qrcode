import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  String? prodID;
  String? code;
  String? name;
  int? price;
  int? qty;

  Products({
    this.prodID,
    this.code,
    this.name,
    this.price,
    this.qty,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        prodID: json["prodID"] ?? "",
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        price: json["price"] ?? 0,
        qty: json["qty"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "prodID": prodID,
        "code": code,
        "name": name,
        "price": price,
        "qty": qty,
      };
}
