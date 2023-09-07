import 'package:betterbin/utils/colors.dart';
import 'package:flutter/material.dart';

class Somethingwentwrong extends StatelessWidget {
  const Somethingwentwrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroungcolor,
      body: Center(
        child: Text(
          "Something went wrong",
          style: TextStyle(fontSize: 20, color: Colors.blue.shade800),
        ),
      ),
    );
  }
}
