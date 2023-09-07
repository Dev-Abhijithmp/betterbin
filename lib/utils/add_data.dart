import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference user = FirebaseFirestore.instance.collection('user');

Future<void> createuserprofile(
  String uid,
  String email,
  String name,
  String phone,
  String role,
) async {
  DocumentReference documentReference = user.doc(uid);

  documentReference.set({
    'id': uid,
    'name': name,
    'email': email,
    'role': role,
    'complaints': 0,
    'phone': phone,
    'isveryfied': false,
  });
}
