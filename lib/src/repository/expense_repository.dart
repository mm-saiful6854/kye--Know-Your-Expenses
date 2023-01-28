import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kye/src/features/authentication/models/user_model.dart';
import 'package:kye/src/repository/user_repository/user_repository.dart';

import '../features/core/models/ExpenseModel.dart';
import 'authentication_repository/authentication_repository.dart';

class ExpenseRepository extends GetxController {
  static ExpenseRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _authRepo = Get.put(AuthenticationRepository());

  addExpenseEntry(ExpenseModel expense) async {
    final userData = await _authRepo.getLoggedInUserData();
    await _db
        .collection("/Users/${userData?.id}/Expenses")
        .add(expense.toJson())
        .whenComplete(() => Get.snackbar("Success", "Expense hase been added.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.brown.withOpacity(0.1),
            colorText: Colors.black))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);

      print(error.toString());
    });
  }

  Future<List<ExpenseModel>> getExpensesByDate(String date) async {
    final userData = await _authRepo.getLoggedInUserData();

    final snapshot = await _db
        .collection("/Users/${userData?.id}/Expenses")
        .where("Date", isEqualTo: date)
        .get();

    var expenseList =
        snapshot.docs.map((e) => ExpenseModel.fromSnapshot(e)).toList();

    return expenseList;
  }

   CollectionReference getExpenseInfoByID(String dbReference) {
    return  _db.collection(dbReference);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getExpenseStreamByDate(
      String date) async {
    final userData = await _authRepo.getLoggedInUserData();

    return await _db
        .collection("/Users/${userData?.id}/Expenses")
        .where("Date", isEqualTo: date)
        .snapshots();
  }

  void updateExpenseInfo(ExpenseModel expense, String dbReference, String docID) async  {
    await _db.collection(dbReference).doc(docID).update(expense.toJson()).whenComplete(() =>
        Get.snackbar("Success", "Expense hase been updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.brown.withOpacity(0.1),
        colorText: Colors.black))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }
}
