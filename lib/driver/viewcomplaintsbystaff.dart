// ignore_for_file: use_build_context_synchronously

import 'package:betterbin/commonpages/loadingpage.dart';
import 'package:betterbin/commonpages/somethingwentwrong.dart';
import 'package:betterbin/public/functions.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:betterbin/utils/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewcomplaintsByStaff extends StatefulWidget {
  const ViewcomplaintsByStaff({Key? key}) : super(key: key);

  @override
  ViewcomplaintsByStaffState createState() => ViewcomplaintsByStaffState();
}

String? value;

class ViewcomplaintsByStaffState extends State<ViewcomplaintsByStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroungcolor,
      appBar: AppBar(
        title: const Text("View request"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError == true) {
            return const Somethingwentwrong();
          } else if (snapshot.connectionState == ConnectionState.active) {
            List<DocumentSnapshot> data = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                List<dynamic> wastetypes = data[index].get('wastetypes');
                Map<String, dynamic> map = data[index].get('location');
                return Container(
                  height: 400,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      border: Border.all(color: green)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Id : ${data[index].get('complaintid')}"),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 160,
                            width: 120,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: green),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        data[index].get('image')))),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Status :  ${data[index].get('status')}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "phone :  ${data[index].get('phone')}"),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  " waste types",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: ListView.builder(
                                    itemCount: wastetypes.length,
                                    itemBuilder:
                                        (BuildContext context, int index1) {
                                      return Text(
                                          wastetypes[index1].toString());
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            items: const [
                              DropdownMenuItem<String>(
                                value: "placed",
                                child: Text("placed"),
                              ),
                              DropdownMenuItem<String>(
                                value: "ongoing",
                                child: Text("ongoing"),
                              ),
                              DropdownMenuItem<String>(
                                value: "completed",
                                child: Text("completed"),
                              ),
                            ],
                            value: value,
                            hint: const Text("Select status"),
                            onChanged: (data) {
                              setState(() {
                                value = data;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              if (value != null) {
                                Map<String, String?> flag =
                                    await updatestatus(data[index].id, value!);
                                if (flag['status'] != "success") {
                                  showDialog(
                                      context: context,
                                      builder: (context) => alert(
                                          "Error", flag['status']!, context));
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => alert("Error",
                                        "Please select status", context));
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(17)),
                              child: const Center(
                                child: Text("Update"),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          await canLaunchUrl(Uri.parse(
                                  "http://maps.google.com/maps?q=${map['latitude']},${map['longitude']}&z=14"))
                              ? await launchUrl(Uri.parse(
                                  "http://maps.google.com/maps?q=${map['latitude']},${map['longitude']}&z=14"))
                              : showDialog(
                                  context: context,
                                  builder: (context) => alert(
                                      "Error", "Cant launch map", context));
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(17)),
                          child: const Center(
                            child: Text("View location"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      data[index].get('status') == 'placed'
                          ? InkWell(
                              onTap: () async {
                                Map<String, String> flag =
                                    await removecomplaint(
                                        data[index].get('complaintid'));
                                if (flag['status'] != "success") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => alert(
                                          "Error", flag['status']!, context));
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(17)),
                                child: const Center(
                                  child: Text(
                                    "remove",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
              itemCount: data.length,
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
