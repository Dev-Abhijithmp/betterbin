import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/commonpages/loadingpage.dart';
import 'package:betterbin/commonpages/somethingwentwrong.dart';
import 'package:betterbin/commonpages/changephonenumber.dart';
import 'package:betterbin/public/viewrequests.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      backgroundColor: backgroungcolor,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError == true) {
            return const Somethingwentwrong();
          } else if (snapshot.hasData == true) {
            DocumentSnapshot data = snapshot.data!;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  profiletile("Name", data.get('name')),
                  profiletile("Phonenumber", data.get('phone')),
                  profiletile("Email", data.get('email')),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Viewcomplaintpublic()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: green),
                      child: const Center(
                        child: Text("View requests"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Changephone()));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: green),
                      child: const Center(
                        child: Text("Change phonenumber"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      signout();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: green),
                      child: const Center(
                        child: Text("Logout"),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}

Widget profiletile(String field, String data) {
  return Container(
    width: double.infinity,
    height: 80,
    margin: const EdgeInsets.all(10),
    child: Card(
      child: ListTile(
        title: Text(
          field,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          data,
          style: const TextStyle(),
        ),
      ),
    ),
  );
}
