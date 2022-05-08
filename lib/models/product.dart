// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Product productFromJson(String str) => Product.fromSnapshot(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.uid,
    required this.name,
    required this.breed,
    required this.category,
    required this.contact,
    required this.age,
    required this.uploadedBy,
    required this.price,
    required this.image,
  });

  String uid;
  String name;
  String breed;
  String category;
  String contact;
  int age;
  String uploadedBy;
  num price;
  String image;

  factory Product.fromSnapshot(QueryDocumentSnapshot<Object?> json) {
    return Product(
        uid: json["uid"],
        name: json["name"],
        breed: json["breed"],
        category: json["category"],
        contact: json["contact"],
        age: json['age'],
        image: json['image'],
        uploadedBy: json['uploadedBy'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "breed": breed,
        "category": category,
        "contact": contact,
        "price": price,
        "age": age,
        "image": image,
        "uploadedBy": uploadedBy,
      };
}
