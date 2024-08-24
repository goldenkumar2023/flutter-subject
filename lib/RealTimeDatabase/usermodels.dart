// To parse this JSON data, do
//
//     final userModels = userModelsFromJson(jsonString);

import 'dart:convert';

UserModels userModelsFromJson(String str) =>
    UserModels.fromJson(json.decode(str));

String userModelsToJson(UserModels data) => json.encode(data.toJson());

class UserModels {
  Customers? customers;
  Sellers? sellers;

  UserModels({
    this.customers,
    this.sellers,
  });

  factory UserModels.fromJson(Map<dynamic, dynamic> json) => UserModels(
        customers: json["Customers"] == null
            ? null
            : Customers.fromJson(json["Customers"]),
        sellers:
            json["Sellers"] == null ? null : Sellers.fromJson(json["Sellers"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "Customers": customers?.toJson(),
        "Sellers": sellers?.toJson(),
      };
}

class Customers {
  String? name;
  int? phone;
  CustomersLocation? location;

  Customers({
    this.name,
    this.phone,
    this.location,
  });

  factory Customers.fromJson(Map<dynamic, dynamic> json) => Customers(
        name: json["name"],
        phone: json["Phone"],
        location: json["location"] == null
            ? null
            : CustomersLocation.fromJson(json["location"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "Phone": phone,
        "location": location?.toJson(),
      };
}

class CustomersLocation {
  String? address;
  int? pin;
  String? landMark;

  CustomersLocation({
    this.address,
    this.pin,
    this.landMark,
  });

  factory CustomersLocation.fromJson(Map<dynamic, dynamic> json) =>
      CustomersLocation(
        address: json["address"],
        pin: json["pin"],
        landMark: json["landMark"],
      );

  Map<dynamic, dynamic> toJson() => {
        "address": address,
        "pin": pin,
        "landMark": landMark,
      };
}

class Sellers {
  String? shopName;
  Owner? owner;
  SellersLocation? location;

  Sellers({
    this.shopName,
    this.owner,
    this.location,
  });

  factory Sellers.fromJson(Map<dynamic, dynamic> json) => Sellers(
        shopName: json["ShopName"],
        owner: json["Owner"] == null ? null : Owner.fromJson(json["Owner"]),
        location: json["location"] == null
            ? null
            : SellersLocation.fromJson(json["location"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "ShopName": shopName,
        "Owner": owner?.toJson(),
        "location": location?.toJson(),
      };
}

class SellersLocation {
  String? address;
  int? phone;
  String? landMark;

  SellersLocation({
    this.address,
    this.phone,
    this.landMark,
  });

  factory SellersLocation.fromJson(Map<dynamic, dynamic> json) =>
      SellersLocation(
        address: json["address"],
        phone: json["Phone"],
        landMark: json["landMark"],
      );

  Map<dynamic, dynamic> toJson() => {
        "address": address,
        "Phone": phone,
        "landMark": landMark,
      };
}

class Owner {
  String? name;
  int? phone;
  String? email;

  Owner({
    this.name,
    this.phone,
    this.email,
  });

  factory Owner.fromJson(Map<dynamic, dynamic> json) => Owner(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
      };
}
