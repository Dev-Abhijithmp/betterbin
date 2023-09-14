// ignore_for_file: prefer_const_constructors

import 'package:betterbin/public/requestpage.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  HomepageState createState() => HomepageState();
}

bool isselected = false;

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
  {
    'title': "Other",
    'images': "images/other.png",
    'isselected': false,
  },
];

class HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    void changeselectionstatetrue(int index) {
      setState(() {
        homewidgetdata[index]['isselected'] = true;
      });
    }

    void changeselectionstatefalse(int index) {
      setState(() {
        homewidgetdata[index]['isselected'] = false;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 3,
        title: Text("home"),
        backgroundColor: green,
      ),
      backgroundColor: backgroungcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (homewidgetdata[0]['isselected'] == true) {
                    changeselectionstatefalse(0);
                  } else {
                    changeselectionstatetrue(0);
                  }
                },
                child: singlegriditem(
                    homewidgetdata[0]['title'],
                    homewidgetdata[0]['images'],
                    homewidgetdata[0]['isselected']),
              ),
              GestureDetector(
                onTap: () {
                  if (homewidgetdata[1]['isselected'] == true) {
                    changeselectionstatefalse(1);
                  } else {
                    changeselectionstatetrue(1);
                  }
                },
                child: singlegriditem(
                    homewidgetdata[1]['title'],
                    homewidgetdata[1]['images'],
                    homewidgetdata[1]['isselected']),
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (homewidgetdata[2]['isselected'] == true) {
                    changeselectionstatefalse(2);
                  } else {
                    changeselectionstatetrue(2);
                  }
                },
                child: singlegriditem(
                    homewidgetdata[2]['title'],
                    homewidgetdata[2]['images'],
                    homewidgetdata[2]['isselected']),
              ),
              GestureDetector(
                onTap: () {
                  if (homewidgetdata[3]['isselected'] == true) {
                    changeselectionstatefalse(3);
                  } else {
                    changeselectionstatetrue(3);
                  }
                },
                child: singlegriditem(
                    homewidgetdata[3]['title'],
                    homewidgetdata[3]['images'],
                    homewidgetdata[3]['isselected']),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (homewidgetdata[4]['isselected'] == true) {
                    changeselectionstatefalse(4);
                  } else {
                    changeselectionstatetrue(4);
                  }
                },
                child: singlegriditem(
                    homewidgetdata[4]['title'],
                    homewidgetdata[4]['images'],
                    homewidgetdata[4]['isselected']),
              ),
              InkWell(
                onTap: () {
                  for (var item in homewidgetdata) {
                    if (item['isselected'] == true) {
                      setState(() {
                        isselected = true;
                      });
                    }
                  }
                  if (homewidgetdata[0]['isselected'] == false &&
                      homewidgetdata[1]['isselected'] == false &&
                      homewidgetdata[2]['isselected'] == false &&
                      homewidgetdata[3]['isselected'] == false &&
                      homewidgetdata[4]['isselected'] == false) {
                    setState(() {
                      isselected = false;
                    });
                  }
                  if (isselected == false) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text("Please Select alteast one item"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("ok"))
                              ],
                            ));
                  } else {
                    List<String> selecteditems = [];
                    for (var item in homewidgetdata) {
                      if (item['isselected'] == true) {
                        selecteditems.add(item['title']);
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Requestpage(
                                  seleceteditems: selecteditems,
                                )));
                  }
                },
                child: Transform.rotate(
                  angle: 40,
                  child: Container(
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: green,
                    ),
                    child: Transform.rotate(
                      angle: -40,
                      child: Center(
                        child: Text("Next"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget singlegriditem(
  String title,
  String url,
  bool isSelected,
) {
  return Container(
    height: 200,
    width: 150,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 130,
          width: 130,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: isSelected ? green : Colors.white,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(color: green),
          ),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(url),
            )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(title)
      ],
    ),
  );
}
