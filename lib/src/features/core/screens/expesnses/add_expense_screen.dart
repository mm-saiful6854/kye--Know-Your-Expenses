import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/features/core/controllers/expense_controller.dart';
import 'package:kye/src/features/core/models/ExpenseModel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aeController = Get.put(ExpenseController());
    aeController.dateController.text = "Today, Right now";
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(mDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Expense",
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
                      controller: aeController.titleController,
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
                      controller: aeController.descController,
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
                          value: aeController.selectedCategory.value,
                          items: aeController.expenseCategory
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? selectedItem) {
                            aeController.changeSelectedItem(selectedItem!);
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: aeController.amountController,
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
                      controller: aeController.dateController,
                      onTap: () => aeController.pickADate(context),
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

                              String dateTime = aeController.dateController.text.trim();
                              if(dateTime == "Today, Right now"){
                                dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                              }
                              var tem = dateTime.split(" ");
                              final expense = ExpenseModel(

                                  title: aeController.titleController.text.trim(),
                                  description: aeController.descController.text.trim(),
                                  category: aeController.selectedCategory.value.trim(),
                                  amount: double.parse(aeController.amountController.text),
                                  date: tem[0],
                                  time: tem[1]);

                              aeController.addExpenseEntry(expense);
                              //SignUpController.instance.registerUser(suController.email.text.trim(), suController.password.text.trim());
                            }
                          },
                          child: Text("Save"),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
