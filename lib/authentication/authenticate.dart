import 'package:betterbin/utils/add_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
//change sign is a stream for knowing if the user is signed in or not
Stream<User?> changesign = auth.authStateChanges();

Future<Map<String, String?>> signinemail(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return {"status": "success"};
  } on FirebaseAuthException catch (e) {
    print(e.toString());

    return {"status": e.message};
  }
}

//function for logout
void signout() async {
  auth.signOut();
  print("Signed out");
}

//to register a new user
Future<Map<String, String?>> register(String email, String password,
    String name, String phone, String role) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    createuserprofile(userCredential.user!.uid, email, name, phone, role);
    return {"status": "success"};
  } on FirebaseAuthException catch (e) {
    print(e.toString());
    return {"status": e.message};
  }
}

//resetting password
Future<Map<String, String?>> sendpassreset(String email) async {
  try {
    await auth.sendPasswordResetEmail(email: email);
    return {"status": "success"};
  } on FirebaseException catch (e) {
    print(e.toString());
    return {"status": e.message};
  }
}

//tochange password
Future<Map<String, String?>> changepass(
    String email, String oldpass, String newpass) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: oldpass);
    await auth.currentUser!.updatePassword(newpass);
    return {'status': "success"};
  } on FirebaseException catch (e) {
    return {'status': e.message.toString()};
  }
}
