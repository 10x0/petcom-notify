// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CustomUser welcomeFromJson(String str) => CustomUser.fromJson(json.decode(str));

String welcomeToJson(CustomUser data) => json.encode(data.toJson());

class CustomUser {
  CustomUser({
    required this.uid,
    required this.name,
    required this.role,
    required this.phoneNumber,
    required this.token,
  });

  String uid;
  String name;
  String role;
  String phoneNumber;
  String token;

  factory CustomUser.fromJson(DocumentSnapshot<Map<String, dynamic>> json) =>
      CustomUser(
        uid: json["uid"],
        name: json["name"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "role": role,
        "phoneNumber": phoneNumber,
        "token": token,
      };
}
