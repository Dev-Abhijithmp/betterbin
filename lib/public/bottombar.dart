import 'package:betterbin/utils/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'profilepage.dart';

class Bottombarpage extends StatefulWidget {
  const Bottombarpage({Key? key}) : super(key: key);

  @override
  BottombarpageState createState() => BottombarpageState();
}

int selectedindex = 0;

class BottombarpageState extends State<Bottombarpage> {
  @override
  Widget build(BuildContext context) {
    void changepage(int index) {
      setState(() {
        selectedindex = index;
      });
    }

    List<Widget> pages = [const Homepage(), const Profilepage()];
    return Scaffold(
        backgroundColor: backgroungcolor,
        body: pages[selectedindex],
        bottomNavigationBar: CurvedNavigationBar(
          color: green,
          backgroundColor: Colors.white,
          index: selectedindex,
          height: 50,
          onTap: (val) {
            changepage(val);
          },
          items: const [
            Icon(Icons.home),
            Icon(Icons.person),
          ],
        ));
  }
}
