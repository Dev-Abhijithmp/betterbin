// ignore_for_file: use_build_context_synchronously

import 'package:betterbin/authentication/authenticate.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Changepassword extends StatelessWidget {
  Changepassword({
    Key? key,
  }) : super(key: key);
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change password"),
        backgroundColor: green,
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 130,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Enter your Current password",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: controller3,
                decoration: InputDecoration(
                  focusedBorder: outbid1(),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: green,
                  ),
                  border: outbid1(),
                  enabledBorder: outbid1(),
                  disabledBorder: outbid1(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Enter your new password",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: outbid1(),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: green,
                  ),
                  border: outbid1(),
                  enabledBorder: outbid1(),
                  disabledBorder: outbid1(),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Confirm your new password",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: controller2,
                decoration: InputDecoration(
                  focusedBorder: outbid1(),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: green,
                  ),
                  border: outbid1(),
                  enabledBorder: outbid1(),
                  disabledBorder: outbid1(),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                if (controller.text == "" ||
                    controller2.text == "" ||
                    controller3.text == "") {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('error'),
                            content: const Text('fill all the fields'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("ok"))
                            ],
                          ));
                } else {
                  Map<String, String?> flag;
                  flag = await changepass(
                      FirebaseAuth.instance.currentUser!.uid,
                      controller3.text,
                      controller.text);
                  if (flag['status'] == "success") {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('success'),
                              content: const Text('success'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("ok"))
                              ],
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('error'),
                              content: Text(flag['status']!),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("ok"))
                              ],
                            ));
                  }
                }
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: green,
                ),
                child: const Center(
                  child: Text(
                    "Change",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

OutlineInputBorder outbid1() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(17),
      borderSide: const BorderSide(color: green));
}
