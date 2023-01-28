import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/constants/text_strings.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(mDefaultSize),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mOTPTitle,
                  style: GoogleFonts.montserrat(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  mOTPSubTitle,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "$mOTPMessage Your Credential",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  keyboardType: TextInputType.number,
                  onSubmit: (code){ print("OTP is $code");},
                ),
                SizedBox(height: 20.0,),
                SizedBox(width: double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: Text("next"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
