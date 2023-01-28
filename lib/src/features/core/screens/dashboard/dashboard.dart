import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:kye/src/constants/image_strings.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/constants/text_strings.dart';
import 'package:kye/src/features/authentication/models/user_model.dart';
import 'package:kye/src/features/core/controllers/dashboard_controller.dart';
import 'package:kye/src/features/core/screens/expesnses/add_expense_screen.dart';
import 'package:kye/src/features/core/screens/expesnses/edit_expense_screen.dart';
import 'package:kye/src/repository/authentication_repository/authentication_repository.dart';
import 'package:kye/src/features/core/screens/profile/profile_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../constants/colors.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final dbController = DashboardController();
    var dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dbController.dateController.text = dateTime;
    dbController.dateSearch.value = dateTime;
    dbController.fromDate.value = dateTime;
    dbController.toDate.value = dateTime;

    /*var firebaseCommand = FirebaseFirestore.instance.collection(
        "/Users/${AuthenticationRepository.instance.loggedInUser.id}/Expenses");*/

    print(
        "/Users/${AuthenticationRepository.instance.loggedInUser.id}/Expenses");

    //${applicationName}
    return Scaffold(
      appBar: AppBar(
        title: Text(mAppName, style: Theme.of(context).textTheme.headline6),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: mPrimaryColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      drawer: drawerFutureBuilder(dbController),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddExpenseScreen());
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(mDashboardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              headerFutureBuilder(dbController, txtTheme),
              const SizedBox(height: mDashboardPadding),
              // seach box
              SearchBoxWidget(dbController: dbController),
              const SizedBox(height: mDashboardPadding),

              FutureBuilder(
                future: dbController.getLoggedInUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      var firebaseCommand = FirebaseFirestore.instance
                          .collection("/Users/${userData.id}/Expenses");
                      return Obx(
                        () => StreamBuilder<QuerySnapshot>(
                            stream: firebaseCommand
                                .where("Date",
                                    isGreaterThanOrEqualTo:
                                        dbController.dateSearch.value)
                                .where("Date",
                                    isLessThanOrEqualTo:
                                        dbController.toDate.value)
                                .snapshots(),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData) {
                                  //print(snapshot.data!.docs.length);
                                  double sum = 0.0;
                                  for (int i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++) {
                                    sum += snapshot.data!.docs[i]["Amount"];
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Expenses:    ${sum} tk",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(8),
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final exModel =
                                                snapshot.data!.docs[index];
                                            String dateStr = DateFormat('yMMMd', 'en_US').format(DateTime.parse(exModel["Date"]));
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white10,
                                              ),
                                              child: Card(
                                                // clipBehavior is necessary because, without it, the InkWell's animation
                                                // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
                                                // This comes with a small performance cost, and you should not set [clipBehavior]
                                                // unless you need it.
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    debugPrint('Card tapped.');
                                                    print("tap on " + exModel["Title"]);
                                                    print("docID: ${exModel.id}, dbReference: /Users/${userData.id}/Expenses");
                                                    Get.to(()=> EditExpenseScreen(dbReference: "/Users/${userData.id}/Expenses", documentId:exModel.id,));
                                                  },
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: SizedBox(
                                                          width: 50,
                                                          height: 100,
                                                          child: Center(child: Text(dateStr, style: Theme.of(context).textTheme.headline6,),),
                                                        ),
                                                        title: Text("${exModel["Title"]}", style: Theme.of(context).textTheme.bodyText1,),
                                                        subtitle: Text(exModel["Description"], style: Theme.of(context).textTheme.bodyText2,),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          TextButton(
                                                            child: Text(exModel["Category"], style: Theme.of(context).textTheme.headline4),
                                                            onPressed: () { },
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text("${exModel["Amount"].toDouble()} tk", style: Theme.of(context).textTheme.bodyText1,),
                                                          ),
                                                          const SizedBox(width: 8),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),











                                              /*GestureDetector(
                                                onTap: (){
                                                  print("tap on "+exModel["Title"]);
                                                  print("docID: ${exModel.id}, dbReference: /Users/${userData.id}/Expenses");
                                                  Get.to(()=> EditExpenseScreen(dbReference: "/Users/${userData.id}/Expenses",
                                                    documentId:exModel.id,));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white12,
                                                  ),
                                                  child: ListTile(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(exModel["Title"]),
                                                        Text(exModel["Category"]),
                                                        Text(
                                                            "${exModel["Amount"].toDouble()} tk"),
                                                      ],
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(exModel["Description"]),
                                                        Text(
                                                          exModel["Date"],
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),*/
                                            );
                                          }),
                                    ],
                                  );
                                  //return listBuilderWidgets;
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text("Has Error"),
                                  );
                                } else {
                                  return const Center(
                                    child: Text("Something went wrong"),
                                  );
                                }
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  } else {
                    // default Column widget
                    return Center(child: Text("Login Error."));
                  }
                },
              ),

              /*Obx(
                () => Container(
                  child: Column(
                    children: [
                      Text(dbController.dateController.text),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: dbController.expenseItems.length,
                        itemBuilder: (context, index) {
                          var ds = dbController.expenseItems[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ds.title),
                                    Text(ds.amount.toString()),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ds.description),
                                    Text(ds.date),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<Object?> headerFutureBuilder(
      DashboardController dbController, TextTheme txtTheme) {
    return FutureBuilder(
      future: dbController.getLoggedInUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data as UserModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hey ${userData.fullname}",
                      style: txtTheme.bodyText1,
                    ),
                    Container(
                      width: 160,
                      height: 35,
                      //padding: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1),
                      ),
                      child: Stack(
                        children: [
                          Obx(
                            () => AnimatedPositioned(
                              duration: Duration(milliseconds: 500),
                              right: dbController.tapOnBtn.value ? -15 : 100,
                              left: dbController.tapOnBtn.value ? 100 : -15,
                              top: dbController.tapOnBtn.value ? 2 : 2,
                              bottom: dbController.tapOnBtn.value ? 2 : 2,
                              child: RawMaterialButton(
                                onPressed: () {
                                  dbController.tapOnWallet();
                                },
                                //elevation: 2.0,
                                fillColor: mPrimaryColor,
                                child: Icon(
                                  color: Colors.white,
                                  Icons.attach_money_outlined,
                                  size: 20.0,
                                ),
                                shape: CircleBorder(),
                              ),
                            ),
                          ),
                          Obx(
                            () => Center(
                              child: dbController.tapOnBtn.value
                                  ? GestureDetector(
                                      onTap: () {
                                        dbController.tapOnWallet();
                                      },
                                      child: Text(
                                          "${userData.balance.toDouble()}"))
                                  : GestureDetector(
                                      onTap: () {
                                        dbController.tapOnWallet();
                                      },
                                      child: Text("Tap for your wallet")),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  mDashboardHeaderTitle,
                  style: txtTheme.headline5,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        } else {
          // default Column widget
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey buddy",
                style: txtTheme.bodyMedium,
              ),
              Text(
                mDashboardHeading,
                style: txtTheme.headline5,
              ),
            ],
          );
        }
      },
    );
  }

  FutureBuilder<Object?> drawerFutureBuilder(DashboardController dbController) {
    return FutureBuilder(
      future: dbController.getLoggedInUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data as UserModel;
            return Drawer(
              elevation: 10,
              child: ListView(
                children: [
                  /*DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                color: Colors.blue,
                child: Column(),
              ),
            ),*/
                  UserAccountsDrawerHeader(
                    accountName: Text(userData.fullname),
                    accountEmail: Text(userData.email),
                    currentAccountPicture: CircleAvatar(
                      foregroundImage: AssetImage(mDashboardProfileImage),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_outline_outlined),
                    title: Text("Profile"),
                    onTap: () {
                      Get.to(() => ProfileScreen());
                    },
                    trailing: Icon(LineAwesomeIcons.angle_right),
                  ),
                  ListTile(
                    leading: Icon(Icons.monetization_on_outlined),
                    title: Text("Add money"),
                    onTap: () {},
                    trailing: Icon(LineAwesomeIcons.angle_right),
                  ),
                  ListTile(
                    leading: Icon(Icons.family_restroom_outlined),
                    title: Text("Family management"),
                    onTap: () {},
                    trailing: Icon(LineAwesomeIcons.angle_right),
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_rounded),
                    title: Text("Logout"),
                    onTap: () {
                      AuthenticationRepository.instance.logout();
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key? key,
    required this.dbController,
  }) : super(key: key);

  final DashboardController dbController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: mPrimaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
        /*border: Border(
          bottom: BorderSide(width: 2),
        ),*/
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cash Flow",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //from time
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        dbController.pickADate(
                            context: context, isFromTime: true);
                      },
                      icon: Icon(Icons.calendar_month_outlined),
                    ),
                    Obx(
                      () => TextButton(
                        onPressed: () {
                          dbController.pickADate(
                              context: context, isFromTime: true);
                        },
                        child: Text(dbController.fromDate.value),
                      ),
                    ),
                  ],
                ),
              ),
              Text("To", style: Theme.of(context).textTheme.bodyText1),
              // to time
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          dbController.pickADate(
                              context: context, isFromTime: false);
                        },
                        icon: Icon(Icons.calendar_month_outlined)),
                    Obx(
                      () => TextButton(
                        onPressed: () {
                          dbController.pickADate(
                              context: context, isFromTime: false);
                        },
                        child: Text(dbController.toDate.value),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      /*TextFormField(
        controller: dbController.dateController,
        onTap: () {
          dbController.pickADate(context);
        },
        decoration: InputDecoration(
          hintText: "Pick a date",
          border: InputBorder.none,
        ),
      ),*/
    );
  }
}
