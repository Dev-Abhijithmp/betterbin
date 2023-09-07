
import 'package:betterbin/utils/colors.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroungcolor,
      body: Center(
        child: CircularProgressIndicator(
          value: 4,
          color: Colors.red,
        ),
      ),
    );
  }
}
