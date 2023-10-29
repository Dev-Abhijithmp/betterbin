import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/authentication/loginpage.dart';
import 'package:betterbin/authentication/userswitcher.dart';
import 'package:betterbin/commonpages/loadingpage.dart';
import 'package:betterbin/commonpages/somethingwentwrong.dart';
import 'package:betterbin/utils/colors.dart';

import 'package:flutter/material.dart';

class Signinout extends StatefulWidget {
  const Signinout({Key? key}) : super(key: key);

  @override
  SigninoutState createState() => SigninoutState();
}

class SigninoutState extends State<Signinout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroungcolor,
      body: StreamBuilder(
          stream: changesign,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Somethingwentwrong();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else if (snapshot.hasData) {
              return const Userswitcher();
            } else {
              return Loginpage();
            }
          }),
    );
  }
}
