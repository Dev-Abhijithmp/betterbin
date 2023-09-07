
import 'package:betterbin/admin/adminpage.dart';
import 'package:betterbin/commonpages/loadingpage.dart';
import 'package:betterbin/commonpages/somethingwentwrong.dart';
import 'package:betterbin/driver/driverpage.dart';
import 'package:betterbin/public/bottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userswitcher extends StatelessWidget {
  const Userswitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection("user").doc(uid).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError == true) {
          return const Somethingwentwrong();
        } else if (snapshot.hasData == true) {
          DocumentSnapshot data = snapshot.data;
          if (data["role"] == "public") {
            return const Bottombarpage();
          } else if (data["role"] == "admin") {
            return const Adminpage();
          } else {
            return const Driverpage();
          }
        } else {
          return const  Loading();
        }
      },
    );
  }
}
