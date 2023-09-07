// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:betterbin/public/functions.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:betterbin/utils/fetchlocation.dart';
import 'package:betterbin/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class Requestpage extends StatefulWidget {
   final List<String> seleceteditems;
  const Requestpage({Key? key, required this.seleceteditems}) : super(key: key);

  @override
  RequestpageState createState() =>
      // ignore: no_logic_in_create_state
      RequestpageState(seleceteditems: seleceteditems);
}

File? _pickedImage;
Position? position;
bool loading = false;
bool show = true;

class RequestpageState extends State<Requestpage> {
  RequestpageState({required this.seleceteditems});
  late final List<String> seleceteditems;
  @override
  Widget build(BuildContext context) {
    void pickImagecamera() async {
      final picker = ImagePicker();
      XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
      File? pickedImageFile;
      pickedImage == null
          ? pickedImageFile = null
          : pickedImageFile = File(pickedImage.path);

      setState(() {
        _pickedImage = pickedImageFile;
      });
      // widget.imagePickFn(pickedImageFile);
    }

    void removeImage() {
      setState(() {
        _pickedImage = null;
      });
    }

    return Scaffold(
      backgroundColor: backgroungcolor,
      appBar: AppBar(
        title: const Text("Request page"),
      ),
      body: Column(
        children: [
          Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: green)),
              child: _pickedImage == null
                  ? const Text("")
                  : Image.file(
                      _pickedImage!,
                      fit: BoxFit.contain,
                    )),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  pickImagecamera();
                },
                child: Container(
                  width: 120,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: green),
                  child: const Center(child: Text("Add image")),
                ),
              ),
              InkWell(
                onTap: () {
                  removeImage();
                },
                child: Container(
                  width: 120,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: green),
                  child: const Center(
                    child: Text("remove image"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Selected items",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: green)),
                child: show == true
                    ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              seleceteditems[index],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                        itemCount: seleceteditems.length,
                      )
                    : Container(),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              if (_pickedImage == null) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        alert("Error", "Please add image", context));
              } else {
                setState(() {
                  loading = true;
                });
                position = await determinePosition();

                Map<String, String> flag =
                    await addimagetostorage(_pickedImage!);
                if (flag['status'] == "success") {
                  Map<String, String> flag1 = await addcomplaint(
                    seleceteditems,
                    flag['url']!,
                    position!,
                  );
                  if (flag1['status'] == "success") {

                    showDialog(
                        context: context,
                        builder: (context) =>
                            alert("success", "Complaint registered", context));
                    setState(() {
                      _pickedImage = null;
                      show = false;
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            alert("error", flag1['status']!, context));
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          alert("error", flag['status']!, context));
                }
                setState(() {
                  loading = false;
                });
              }
            },
            child: Container(
              height: 45,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: green,
              ),
              child: Center(
                child: loading == true ? const Text("Loading...") : const Text("Submit"),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
