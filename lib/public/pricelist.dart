import 'package:betterbin/utils/colors.dart';
import 'package:flutter/material.dart';

class PricePage extends StatelessWidget {
  PricePage({super.key});
  List<double> prices = [
    30.0,
    15.0,
    20.0,
    0.0,
  ];
  List<Map<String, dynamic>> homewidgetdata = [
    {
      'title': "plastic",
      'images': "images/plastic.png",
      'isselected': false,
    },
    {
      'title': "E-waste",
      'images': "images/ewaste.png",
      'isselected': false,
    },
    {
      'title': "Scrap",
      'images': "images/scrap.png",
      'isselected': false,
    },
    {
      'title': "Food",
      'images': "images/food.png",
      'isselected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 3,
        title: const Text("Price Page"),
        backgroundColor: green,
      ),
      backgroundColor: backgroungcolor,
      body: ListView.builder(
          itemCount: homewidgetdata.length,
          itemBuilder: (context, index) => Container(
              height: 45,
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: green)),
              child: Center(
                child: Text(homewidgetdata[index]['title'] +
                    " : " +
                    prices[index].toString() +
                    "Rs"),
              ))),
    );
  }
}
