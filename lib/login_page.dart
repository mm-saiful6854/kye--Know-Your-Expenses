import 'package:flutter/material.dart';
import 'package:kye/register_page.dart';
import 'package:kye/welcome_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KYE - Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // logo
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              child: Image.asset(
                'images/kye_logo2.png',
                height: 300,
              ),
            ),
            //Email input
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Email',
                ),
              ),
            ),
            // password input
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Password',
                ),
              ),
            ),
            // login button
            ElevatedButton(
              onPressed: () {
                debugPrint("Login press");
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext buildContext) {
                    return const WelcomePage();
                  }),
                );
              },
              child: const Text('Login'),
            ),
            //gap
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 16),
                  child: OutlinedButton(
                    onPressed: () {
                      debugPrint("Register press");
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext buildContext) {
                          return const RegisterPage();
                        }),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
