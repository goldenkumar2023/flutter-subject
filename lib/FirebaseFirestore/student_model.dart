// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  String? email;
  String? name;
  String? number;
  String? studentsId;

  StudentModel({
    this.email,
    this.name,
    this.number,
    this.studentsId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        email: json["email"],
        name: json["name"],
        number: json["number"],
        studentsId: json["students_id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "number": number,
        "students_id": studentsId,
      };
}
