import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

List<double> prices = [
  30.0,
  15.0,
  20.0,
  0.0,
];

Future<Map<String, String>> addcomplaint(List<Map<String, dynamic>> types,
    String url, Position position, double totalPrice) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<String> stypes = [];
    for (var element in types) {
      stypes.add(element['title']);
    }

    await FirebaseFirestore.instance
        .collection('complaints')
        .doc(FirebaseAuth.instance.currentUser!.uid +
            (documentSnapshot.get('complaints').toString()))
        .set({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'complaintid': (FirebaseAuth.instance.currentUser!.uid +
          (documentSnapshot.get('complaints').toString())),
      'wastetypes': types,
      'status': "placed",
      'image': url,
      'date':DateTime.now(),
      'phone': documentSnapshot.get('phone'),
      'totalprice': totalPrice,
      'location': {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
    });
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'complaints': (documentSnapshot.get('complaints') + 1)});
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

FirebaseStorage firebaseStorage = FirebaseStorage.instance;
Future<Map<String, String>> addimagetostorage(File images) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    await FirebaseStorage.instance
        .ref(
            'complaintimages/${FirebaseAuth.instance.currentUser!.uid}${documentSnapshot.get('complaints')}')
        .putFile(images);
    String sample = await FirebaseStorage.instance
        .ref(
            'complaintimages/${FirebaseAuth.instance.currentUser!.uid}${documentSnapshot.get('complaints')}')
        .getDownloadURL();

    return {'status': "success", 'url': sample.toString()};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

Future<Map<String, String>> removecomplaint(String complaintid) async {
  try {
    await FirebaseFirestore.instance
        .collection('complaints')
        .doc(complaintid)
        .delete();

    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

double getTotal(List<double> data, List<Map<String, dynamic>> selecteditems) {
  double total = 0;
  for (int i = 0; i < selecteditems.length; i++) {
    total += (data[i] * selecteditems[i]['price']);
  }

  return total;
}

Future<Map<String, String?>> changephone(String uid, String phone) async {
  try {
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'phone': phone,
    });
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}

Future<Map<String, String?>> updatestatus(
    String compliantid, String status) async {
  try {
    await FirebaseFirestore.instance
        .collection('complaints')
        .doc(compliantid)
        .update({
      'status': status,
    });
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}
