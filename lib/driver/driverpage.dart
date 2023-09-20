import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/commonpages/changephonenumber.dart';
import 'package:betterbin/commonpages/changepassword.dart';
import 'package:betterbin/commonpages/loadingpage.dart';
import 'package:betterbin/commonpages/somethingwentwrong.dart';
import 'package:betterbin/driver/viewcomplaintsbystaff.dart';
import 'package:betterbin/public/profilepage.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Driverpage extends StatelessWidget {
  const Driverpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroungcolor,
      appBar: AppBar(
        title: const Text("Betterbin Driver"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(includeMetadataChanges: true),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData == true) {
            DocumentSnapshot doc = snapshot.data!;
            if (doc.get('isverified') == true) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  profiletile("Name", doc.get('name')),
                  profiletile("Email", doc.get('email')),
                  profiletile("Phone", doc.get('phone')),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ViewcomplaintsByStaff()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: green,
                      ),
                      child: const Center(child: Text("View requests")),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Changepassword()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: green,
                      ),
                      child: const Center(child: Text("Change password")),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Changephone()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: green,
                      ),
                      child: const Center(child: Text("Change Phone")),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      signout();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: green,
                      ),
                      child: const Center(child: Text("Logout")),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const Center(
                    child: Text(
                      "Verification is not completed",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                  InkWell(
                    onTap: () {
                      signout();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: green,
                      ),
                      child: const Center(child: Text("Logout")),
                    ),
                  ),
                ],
              );
            }
          } else if (snapshot.hasError == true) {
            return const Somethingwentwrong();
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
