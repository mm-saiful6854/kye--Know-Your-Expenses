import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kye/src/features/authentication/models/user_model.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';
import 'package:kye/src/repository/expense_repository.dart';
import 'package:kye/src/repository/user_repository/user_repository.dart';

import '../models/ExpenseModel.dart';

class DashboardController extends GetxController{
  final TextEditingController dateController = TextEditingController();

  final _userRepo = Get.put(UserRepository());
  final _expenseRepo = Get.put(ExpenseRepository());
  final _authRepo = Get.put(AuthenticationRepository());

  RxBool tapOnBtn = false.obs;

  RxString dateSearch = "Today".obs;
  RxString toDate = "Today".obs;
  RxString fromDate = "Today".obs;
  RxList<ExpenseModel> expenseItems = [ExpenseModel(title: "Title", description: "description", category: "category", amount: 0.0, date: "date", time: "time")].obs;

  void pickADate({required BuildContext context, bool isFromTime=true}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(dateController.text),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      //debugPrint(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate =
      DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      /*setState(() {
                        _dateController.text =
                            formattedDate; //set output date to TextField value.
                      });*/
      dateController.text = formattedDate;
      dateSearch.value = formattedDate;
      if(isFromTime)
        fromDate.value = formattedDate;
      else
        toDate.value = formattedDate;
     // getExpensesByDate();
    }
  }

  tapOnWallet() async {

    await Future.delayed(const Duration(milliseconds: 500));
    tapOnBtn.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    tapOnBtn.value = false;
    await Future.delayed(const Duration(milliseconds: 500));
  }

  getLoggedInUser(){
    return _authRepo.getLoggedInUserData();
  }

  Future<void> getExpensesByDate() async {
    expenseItems.value =[];
    expenseItems.value = await _expenseRepo.getExpensesByDate(dateSearch.value.trim()) as List<ExpenseModel>;
  }


  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getExpenseStreamByDate() async{
    return await _expenseRepo.getExpenseStreamByDate(dateSearch.value.trim());
  }
}