import 'package:flutter/material.dart';
import 'package:kye/configuration_page.dart';
import 'package:kye/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KYE'),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint("skip");
              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext buildContext) {
                  return const HomePage();
                }),
              );*/
              Navigator.of(context).popUntil(ModalRoute.withName('/welcome'));
              Navigator.of(context).pushNamed('/root');
            },
            child: const Text(
              "skip",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            child: const Center(
              child: Text(
                'Make Your family to track your Expense',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.brown,
                ),
              ),
            ),
          ),

          //gap
          const SizedBox(
            height: 100,
          ),


          // continue button

          OutlinedButton(
            onPressed: () {
              debugPrint("Continue...");
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext buildContext) {
                  return const ConfigurationPage();
                }),
              );
            },
            child: const Text(
              "Continue...",
              style: TextStyle(
                fontSize: 15,
                color: Colors.brown,
              ),
            ),
          ),
        ],
      ),

    );
  }
}
