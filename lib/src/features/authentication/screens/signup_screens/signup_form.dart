import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kye/src/constants/colors.dart';
import 'package:kye/src/features/authentication/models/user_model.dart';

import '../../controllers/signup_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
// final suController = Get.put(SignUpController());
    final _formKey = GlobalKey<FormFieldState>();
    final suController = SignUpController();
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            TextFormField(
              controller: suController.fullname,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline_outlined,
                  color: mPrimaryColor,
                ),
                labelText: "Full Name",
                hintText: "Full Name",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: suController.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: "E-Mail",
                hintText: "E-Mail",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: suController.phoneNo,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: "Phone No",
                hintText: "Phone No",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: suController.password,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.security_outlined),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye_sharp),
                ),
                labelText: "Password",
                hintText: "Password",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = UserModel(
                          email: suController.email.text.trim(),
                          password: suController.password.text.trim(),
                          fullname: suController.fullname.text.trim(),
                          phoneNo: suController.phoneNo.text.trim());
                      suController.createUser(user);
                      //SignUpController.instance.registerUser(suController.email.text.trim(), suController.password.text.trim());
                    }
                  },
                  child: Text("SignUp".toUpperCase())),
            ),
          ],
        ),
      ),
    );
  }
}
