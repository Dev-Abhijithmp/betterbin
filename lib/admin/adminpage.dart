import 'package:betterbin/admin/viewcomplaintsadmin.dart';
import 'package:betterbin/admin/viewstaff.dart';
import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:flutter/material.dart';

class Adminpage extends StatelessWidget {
  const Adminpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        backgroundColor: blue,
      ),
      backgroundColor: backgroungcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Viewstaff()));
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: blue,
              ),
              child: const Center(
                child: Text("view Staff"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewcomplaintAdmin()));
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: blue,
              ),
              child: const Center(
                child: Text("View Complaints"),
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
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: blue,
              ),
              child: const Center(
                child: Text("Logout "),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
