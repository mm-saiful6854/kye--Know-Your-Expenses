import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kye/widgets.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';
import 'authentication.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var now = DateTime.now();
  var formatter = DateFormat('Mon-DD-YYYY');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      /*appBar: AppBar(
        title: const Text('KYE'),
    ),*/
      body: ListView(
        children: <Widget>[
          Image.asset('images/family.jpg'),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Know Your Expense - KYE',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("How's going your day!"),
          const Paragraph(
            'Remember: Allah (SWT) encouraged believers on frugality.',
          ),
        ],
      ),
    );
  }
}

/*class LandingPage extends StatelessWidget {
   LandingPage({Key? key}) : super(key: key);

  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      */ /*appBar: AppBar(
        title: const Text('KYE'),
      ),*/ /*
      body: ListView(

        children: <Widget>[
          Image.asset('images/family.jpg'),
          const SizedBox(height: 8),
          IconAndDetail(Icons.calendar_today, formatter.format(now)),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("How's going your day!"),
          const Paragraph(
            'Remember: Allah (SWT) encouraged believers on frugality.',
          ),
        ],
      ),
    );
  }
}*/
