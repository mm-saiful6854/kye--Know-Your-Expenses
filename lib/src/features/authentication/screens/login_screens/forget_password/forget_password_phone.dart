import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kye/src/common_widgets/form/form_header_widget.dart';
import 'package:kye/src/constants/image_strings.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/constants/text_strings.dart';
import 'package:kye/src/features/authentication/screens/login_screens/forget_password/otp_screen.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(mDefaultSize),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FormHeaderWidget(
                  image: mWelcomeScreenImage,
                  title: mForgetPassword,
                  subtitle: mForgetPasswordSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text(mPhoneNo),
                          hintText: mPhoneNo,
                          prefixIcon: Icon(Icons.mobile_friendly_rounded),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            child: Text("Next"), onPressed: () {
                              Get.to(()=>OTPScreen());
                        }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
