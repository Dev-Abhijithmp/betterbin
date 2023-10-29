// ignore_for_file: use_build_context_synchronously

import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/authentication/forgot.dart';
import 'package:betterbin/authentication/signuppage.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:betterbin/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextEditingController controlleremail = TextEditingController();
TextEditingController controllerpassl = TextEditingController();

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool visib = true;

  void changevisib() {
    visib = !visib;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroungcolor,
      body: Form(
        key: KeyClass.loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 90,
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
            const Text(
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
                controller: controlleremail,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: out(),
                    enabledBorder: out(),
                    disabledBorder: out(),
                    focusedBorder: out(),
                    errorBorder: out()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                obscureText: visib,
                controller: controllerpassl,
                onChanged: (value) =>
                    KeyClass.loginFormKey.currentState?.validate(),
                validator: (value) {
                  if (value!.length < 6) {
                    return "minmum 6 digit required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: "Password",
                    border: out(),
                    enabledBorder: out(),
                    disabledBorder: out(),
                    focusedBorder: out(),
                    errorBorder: out(),
                    errorStyle: TextStyle(),
                    suffix: visib
                        ? IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () => changevisib(),
                          )
                        : IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () => changevisib(),
                          )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (KeyClass.loginFormKey.currentState!.validate()) {
                      if (controlleremail.text == "" ||
                          controllerpassl.text == "") {
                        showDialog(
                            context: context,
                            builder: (context) => alert("error",
                                "please fill all the fields", context));
                      } else {
                        Map<String, String?> flag = await signinemail(
                            controlleremail.text, controllerpassl.text);
                        if (flag['status'] == "success") {
                          controlleremail.clear();
                          controllerpassl.clear();
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  alert("Error", flag['status']!, context));
                        }
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
                        "login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Forgotpage()));
                    },
                    child: const Text("Forgot password"))
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Signuppage()),
                  );
                },
                child: const Text("Create new Account"))
          ],
        ),
      ),
    );
  }
}

OutlineInputBorder out() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(17),
      borderSide: const BorderSide(color: green));
}
