// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Order welcomeFromJson(String str) => Order.fromJson(json.decode(str));

String welcomeToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({required this.uid, required this.products});

  String uid;
  String products;

  factory Order.fromJson(DocumentSnapshot<Map<String, dynamic>> json) =>
      Order(uid: json["uid"], products: json["products"]);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "products": products,
      };
}
