import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String? id;
  late final String fullname;
  late final String email;
  late final String phoneNo;
  late final String password;
  late final num balance;

  UserModel(
      {this.id,
      required this.email,
      required this.password,
      required this.fullname,
      required this.phoneNo,
      this.balance = 0.0});

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        password: data["Password"],
        fullname: data["Fullname"],
        phoneNo: data["Phone"],
        balance: data["Balance"]);
  }

  toJson() {
    return {
      "Fullname": fullname,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "Balance": balance
    };
  }
}
