import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/features/core/controllers/expense_controller.dart';
import 'package:kye/src/features/core/models/ExpenseModel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditExpenseScreen extends StatelessWidget {

  final String documentId;
  final String dbReference;
  const EditExpenseScreen({Key? key,
    required this.dbReference,
    required this.documentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eController = Get.put(ExpenseController());
    eController.dateController.text = "Today, Right now";
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: eController.getExpenseInfo(dbReference).doc(documentId).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                //ExpenseModel expenseModel = snapshot.data as ExpenseModel;
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                eController.titleController.text = data["Title"];
                eController.descController.text = data["Description"];
                eController.dateController.text = data["Date"];
                eController.amountController.text = data["Amount"].toString();
                eController.selectedCategory.value = data["Category"];

                print(data);
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(mDefaultSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Edit Expense",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          "Tracking expense can help you.",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Divider(
                          thickness: 2.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // title
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: eController.titleController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.title_rounded),
                                  hintText: "Title",
                                  labelText: "Title",
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: eController.descController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.description),
                                  hintText: "Description",
                                  labelText: "Description",
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // expense category
                              Obx(
                                () => DropdownButton(
                                    underline: Container(
                                      height: 2,
                                      color: Colors.brown,
                                    ),
                                    isExpanded: true,
                                    value: eController.selectedCategory.value,
                                    items: eController.expenseCategory
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? selectedItem) {
                                      eController
                                          .changeSelectedItem(selectedItem!);
                                    }),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: eController.amountController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.attach_money_outlined),
                                  hintText: "Amount",
                                  labelText: "Amount",
                                ),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: eController.dateController,
                                onTap: () => eController.pickADate(context),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.date_range_rounded),
                                  hintText: "Date",
                                  labelText: "Date",
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        String dateTime = eController
                                            .dateController.text
                                            .trim();
                                        if (dateTime == "Today, Right now") {
                                          dateTime =
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(DateTime.now());
                                        }
                                        var tem = dateTime.split(" ");
                                        final expense = ExpenseModel(
                                            title: eController
                                                .titleController.text
                                                .trim(),
                                            description: eController
                                                .descController.text
                                                .trim(),
                                            category: eController
                                                .selectedCategory.value
                                                .trim(),
                                            amount: double.parse(eController
                                                .amountController.text),
                                            date: tem[0],
                                            time: tem.length!=2?"00:00:00":tem[1]);

                                        eController.updateExpenseInfo(expense, dbReference, documentId);
                                        //SignUpController.instance.registerUser(suController.email.text.trim(), suController.password.text.trim());
                                      }
                                    },
                                    child: Text("Update"),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("hasError : "+snapshot.error.toString()));
              }else if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }else {
                return const Center(child: Text("Something went wrong"));
              }
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          }),
    ));
  }
}
