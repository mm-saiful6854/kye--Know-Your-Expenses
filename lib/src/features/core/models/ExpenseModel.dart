import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  late final String? id;
  late final String title;
  late final String description;
  late final String category;
  late final double amount;
  late final String date;
  late final String time;

  ExpenseModel(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.amount,
      required this.date,
      required this.time});

  toJson() {
    return {
      "Title": title,
      "Description": description,
      "Category": category,
      "Amount": amount,
      "Date": date,
      "Time": time
    };
  }

  factory ExpenseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ExpenseModel(
        id: document.id,
        title: data["Title"],
        description: data["Description"],
        category: data["Category"],
        amount: data["Amount"],
        date: data["Date"],
        time: data["Time"]);
  }
}
