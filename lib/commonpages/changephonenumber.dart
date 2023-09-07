// ignore_for_file: use_build_context_synchronously

import 'package:betterbin/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../public/functions.dart';

class Changephone extends StatelessWidget {
  Changephone({
    Key? key,
  }) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Change phonenumber"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 120,
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Enter phone number",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                maxLength: 10,
                controller: controller,
                decoration: InputDecoration(
                  prefixText: "+91",
                  focusedBorder: outbid1(),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.phone,
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
                if (controller.text.length < 10) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('error'),
                            content: const Text('phone number must be 10 digit'),
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
                  flag = await changephone(
                      FirebaseAuth.instance.currentUser!.uid, controller.text);
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
                    controller.clear();
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
