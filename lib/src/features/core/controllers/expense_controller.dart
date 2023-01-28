import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kye/src/features/core/screens/dashboard/dashboard.dart';

import '../../../repository/expense_repository.dart';
import '../models/ExpenseModel.dart';

class ExpenseController extends GetxController {
  static ExpenseController get instance => Get.find();

  RxString selectedCategory = "Select Category".obs;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  final _expenseRepo = Get.put(ExpenseRepository());

  List<String> expenseCategory = [
    "Select Category",
    'Rent',
    'tution fee',
    'Shopping',
    'Travelling',
    'Outing',
    'Medicine',
    'Cosmitics',
    'Saving'
  ];

  void changeSelectedItem(String selectedItem) {
    selectedCategory.value = selectedItem!;
  }

  void addExpenseEntry(ExpenseModel expense){
    _expenseRepo.addExpenseEntry(expense);
    Get.offAll(()=> Dashboard());
  }


  void pickADate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(dateController.text),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      //debugPrint(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      /*setState(() {
                        _dateController.text =
                            formattedDate; //set output date to TextField value.
                      });*/
      dateController.text = formattedDate;
    }
  }

  CollectionReference getExpenseInfo(String dbReference) {
    return _expenseRepo.getExpenseInfoByID(dbReference);
  }

  updateExpenseInfo(ExpenseModel expense, String dbRef, String docID) async{
    _expenseRepo.updateExpenseInfo(expense, dbRef, docID);
    Get.offAll(()=> Dashboard());
  }
}
