// ignore_for_file: use_build_context_synchronously

import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:betterbin/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginpage.dart';

TextEditingController controllername = TextEditingController();
TextEditingController controllermail = TextEditingController();
TextEditingController controllerphone = TextEditingController();
TextEditingController controllerpass = TextEditingController();
TextEditingController controllerpass1 = TextEditingController();

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  SignuppageState createState() => SignuppageState();
}

String? value;
bool visib1 = true;
bool visib2 = true;

class SignuppageState extends State<Signuppage> {
  void changevisib1() {
    visib1 = !visib1;
    setState(() {});
  }

  void changevisib2() {
    visib2 = !visib2;
    setState(() {});
  }

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
              const SizedBox(
                height: 100,
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
                  controller: controllername,
                  decoration: InputDecoration(
                    labelText: "Name",
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
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: controllermail,
                  keyboardType: TextInputType.emailAddress,
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
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: controllerphone,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    prefixText: "+91",
                    labelText: "Phone",
                    border: out(),
                    enabledBorder: out(),
                    disabledBorder: out(),
                    focusedBorder: out(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  obscureText: visib1,
                  controller: controllerpass,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: out(),
                      enabledBorder: out(),
                      disabledBorder: out(),
                      focusedBorder: out(),
                      suffix: visib1
                          ? IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () => changevisib1(),
                            )
                          : IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () => changevisib1(),
                            )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  obscureText: visib2,
                  controller: controllerpass1,
                  decoration: InputDecoration(
                      labelText: "verify password",
                      border: out(),
                      enabledBorder: out(),
                      disabledBorder: out(),
                      focusedBorder: out(),
                      suffix: visib2
                          ? IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () => changevisib2(),
                            )
                          : IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () => changevisib2(),
                            )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              DropdownButton<String>(
                items: const [
                  DropdownMenuItem<String>(
                    value: "public",
                    child: Text("public"),
                  ),
                  DropdownMenuItem<String>(
                    value: "staff",
                    child: Text("staff"),
                  ),
                ],
                value: value,
                hint: const Text("Select role"),
                onChanged: (data) {
                  setState(() {
                    value = data;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (controllermail.text == "" ||
                      controllername.text == "" ||
                      controllerphone.text.length < 10 ||
                      controllerpass.text == "" ||
                      controllerpass1.text == "" ||
                      value == null) {
                    showDialog(
                        context: context,
                        builder: (context) => alert(
                            "Error", "please  fill all the fields", context));
                  } else {
                    if (controllerpass.text == controllerpass1.text) {
                      Map<String, String?> flag = await register(
                          controllermail.text,
                          controllerpass.text,
                          controllername.text,
                          controllerphone.text,
                          value!);
                      if (flag['status'] != 'success') {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                alert("Error", flag['status']!, context));
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              alert("Error", "passwords didnt match", context));
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
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
