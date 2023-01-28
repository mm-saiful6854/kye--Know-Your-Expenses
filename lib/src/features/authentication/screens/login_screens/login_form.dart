import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/features/authentication/controllers/login_controller.dart';
import 'package:kye/src/features/authentication/screens/login_screens/forget_password/forget_password_btn_widget.dart';
import 'package:kye/src/features/authentication/screens/login_screens/forget_password/forget_password_mail.dart';
import 'package:kye/src/features/authentication/screens/login_screens/forget_password/forget_password_phone.dart';

import '../../../../constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormFieldState>();
    final lController = LoginController();
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: lController.email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: mEmail,
                  hintText: mEmail,
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
                controller: lController.password,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye_sharp),
                  ),
                  labelText: mPassword,
                  hintText: mPassword,
                  border: OutlineInputBorder(),
                ),
              ),

              //--- Forget Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    buildShowModalBottomSheet(context);
                  },
                  child: Text(mForgetPassword),
                ),
              ),
              SizedBox(width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    lController.loginWithEmailAndPassword(lController.email.text.trim(),
                        lController.password.text.trim());
                  },
                  child: Text(mLogin),),),
            ],
          ),
        ));
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        builder: (context) =>
            Container(
              padding: EdgeInsets.all(mDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mForgetPasswordTitle, style: Theme
                      .of(context)
                      .textTheme
                      .headline5,),
                  Text(mForgetPasswordSubTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,),
                  SizedBox(height: 30.0,),
                  ForgetPasswordBtnWidget(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => ForgetPasswordMailScreen());
                    },
                    btnIcon: Icons.mail_outline_rounded,
                    title: mEmail,
                    subTitle: mResetViaEMail,
                  ),
                  SizedBox(height: 10.0,),
                  ForgetPasswordBtnWidget(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => ForgetPasswordPhoneScreen());
                    },
                    btnIcon: Icons.mobile_friendly_rounded,
                    title: mPassword,
                    subTitle: mResetViaPhone,
                  ),
                ],
              ),
            ));
  }
}

