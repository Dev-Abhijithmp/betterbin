import 'dart:io';
import 'package:betterbin/authentication/loginpage.dart';
import 'package:betterbin/public/functions.dart';
import 'package:betterbin/utils/colors.dart';
import 'package:betterbin/utils/fetchlocation.dart';
import 'package:betterbin/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class Requestpage extends StatefulWidget {
  const Requestpage({
    Key? key,
    required this.seleceteditems,
  }) : super(key: key);
  final List<Map<String, dynamic>> seleceteditems;

  @override
  RequestpageState createState() =>

      // ignore: no_logic_in_create_state
      RequestpageState();
}

File? _pickedImage;
Position? position;
bool loading = false;
bool show = true;

double totalprice = 0;
TextEditingController priceController = TextEditingController();
List<double> selectedPrices = [0, 0, 0, 0, 0];

class RequestpageState extends State<Requestpage> {
  @override
  Widget build(BuildContext context) {
    void pickImagecamera() async {
      final picker = ImagePicker();
      XFile? pickedImage =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 5);
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
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroungcolor,
      appBar: AppBar(
        title: const Text("Request page"),
      ),
      body: Column(
        children: [
          Container(
              height: 180,
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
              SizedBox(
                height: 200,
                child: show == true
                    ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: SizedBox(
                                    width: 400,
                                    height: 200,
                                    child: Form(
                                      key: KeyClass.formKey,
                                      child: TextFormField(
                                        controller: priceController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please enter a value';
                                          } else if (int.parse(value) > 5) {
                                            return "Not allowed weight more than 5";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) => KeyClass.formKey.currentState!.validate(),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration:
                                            InputDecoration(border: out()),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("cancel")),
                                    ElevatedButton(
                                        onPressed: () {
                                          selectedPrices[index] = double.parse(
                                              priceController.text.toString());
                                          print(
                                              priceController.text.toString());

                                          setState(() {});
                                          print(selectedPrices[index]);
                                          totalprice = getTotal(selectedPrices,
                                              widget.seleceteditems);
                                          priceController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: const Text("ok"))
                                  ],
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.seleceteditems[index]['title']}(${widget.seleceteditems[index]['price']} Rs per KG) : ${selectedPrices[index]} KG =${widget.seleceteditems[index]['price'] * selectedPrices[index]} Rs ",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                        itemCount: widget.seleceteditems.length,
                      )
                    : Container(),
              ),
              Text(
                "$totalprice Rs",
                style: const TextStyle(
                  fontSize: 20,
                ),
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
                bool containweight = true;
                for (var i = 0; i < widget.seleceteditems.length; i++) {
                  if (selectedPrices[i] == 0) {
                    containweight = false;
                  }
                }

                if (!containweight) {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          alert("Error", "Please add weight", context));
                } else {
                  setState(() {
                    loading = true;
                  });
                  position = await determinePosition();

                  Map<String, String> flag =
                      await addimagetostorage(_pickedImage!);
                  if (flag['status'] == "success") {
                    Map<String, String> flag1 = await addcomplaint(
                      widget.seleceteditems,
                      flag['url']!,
                      position!,
                      totalprice,
                    );
                    if (flag1['status'] == "success") {
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (context) => alert("success",
                              "Request send Successfully ", context));
                      setState(() {
                        _pickedImage = null;
                        show = false;
                      });
                    } else {
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (context) =>
                              alert("error", flag1['status']!, context));
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        builder: (context) =>
                            alert("error", flag['status']!, context));
                  }
                  setState(() {
                    loading = false;
                  });
                }
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
                child: loading == true
                    ? const Text("Loading...")
                    : const Text("Submit"),
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
