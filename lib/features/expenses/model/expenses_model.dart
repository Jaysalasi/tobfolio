
import 'dart:convert';

class Expense {
  final String id;
  final String propertyId;
  final String type;
  final String description;
  final dynamic cost;
  final String status;

  Expense({
    required this.id,
    required this.propertyId,
    required this.type,
    required this.description,
    required this.cost,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'type': type,
      'description': description,
      'cost': cost,
      'status': status,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['_id'] ?? '',
      propertyId: json['propertyId'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      cost: (json['cost'] ?? 0),
      status: json['status'] ?? '',
    );
  }
}

// To parse this JSON data, do
//
//     final expensesModel = expensesModelFromJson(jsonString);


List<ExpensesModel> expensesModelFromJson(String str) => List<ExpensesModel>.from(json.decode(str).map((x) => ExpensesModel.fromJson(x)));

String expensesModelToJson(List<ExpensesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpensesModel {
    final String? id;
    final String? landlordId;
    final PropertyId? propertyId;
    final String? type;
    final int? cost;
    final String? description;
    final String? status;
    final String? date;
    final String? createdAt;
    final int? v;

    ExpensesModel({
        this.id,
        this.landlordId,
        this.propertyId,
        this.type,
        this.cost,
        this.description,
        this.status,
        this.date,
        this.createdAt,
        this.v,
    });

    factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["_id"],
        landlordId: json["landlordId"],
        propertyId: json["propertyId"] == null ? null : PropertyId.fromJson(json["propertyId"]),
        type: json["type"],
        cost: json["cost"],
        description: json["description"],
        status: json["status"],
        date: json["date"],
        createdAt: json["createdAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "landlordId": landlordId,
        "propertyId": propertyId?.toJson(),
        "type": type,
        "cost": cost,
        "description": description,
        "status": status,
        "date": date,
        "createdAt": createdAt,
        "__v": v,
    };
}

class PropertyId {
    final String? id;
    final String? name;

    PropertyId({
        this.id,
        this.name,
    });

    factory PropertyId.fromJson(Map<String, dynamic> json) => PropertyId(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
