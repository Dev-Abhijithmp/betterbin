// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:betterbin/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'loginpage.dart';

class Forgotpage extends StatelessWidget {
  Forgotpage({Key? key}) : super(key: key);
  TextEditingController resetemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: backgroungcolor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const  SizedBox(
                height: 130,
              ),
              Image.asset(
                "images/recycle.jpg",
                fit: BoxFit.fill,
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 20,
              ),
             const  Text(
                "BetterBin",
                style: TextStyle(
                    color: green, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: resetemail,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: out(),
                    enabledBorder: out(),
                    disabledBorder: out(),
                    focusedBorder: out(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (resetemail.text == "") {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            alert("Error", "Please fill email", context));
                  } else {
                    Map<String, String?> flag =
                        await sendpassreset(resetemail.text);
                    if (flag['status'] != "success") {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              alert("Error", flag['status']!, context));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              alert("Success", flag['status']!, context));
                      resetemail.clear();
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17), color: green),
                  child: const Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
