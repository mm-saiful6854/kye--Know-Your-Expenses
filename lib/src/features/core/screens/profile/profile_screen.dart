import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kye/src/constants/image_strings.dart';
import 'package:kye/src/constants/sizes.dart';
import 'package:kye/src/features/authentication/models/user_model.dart';
import 'package:kye/src/features/core/controllers/profile_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(mDefaultSize),
          child: FutureBuilder(
            future: profileController.getLoggedInUserInfo(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    UserModel userData = snapshot.data as UserModel;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: AssetImage(mDashboardProfileImage),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.brown),
                              child: Icon(
                                LineAwesomeIcons.camera,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(userData.fullname,
                                    style: Theme.of(context).textTheme.headline6),
                                Container(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(5),
                                          top: Radius.circular(5)),
                                      color: Colors.white38),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(userData.email),
                                Container(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(5),
                                          top: Radius.circular(5)),
                                      color: Colors.white38),
                                  child: IconButton(
                                      onPressed: () {
                                        buildShowDialog(context);
                                      },
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(
                            width: 200.0,
                            child: ElevatedButton(onPressed: () {}, child: Text("Save")))
                      ],
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  else {
                    return const Center(child: Text("Something went wrong"));
                  }
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(
    BuildContext context,
  ) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Enter your new Email"),
              content: Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: null,
                    hintText: "Email",
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Ok"),
                ),
              ],
            ));
  }
}
