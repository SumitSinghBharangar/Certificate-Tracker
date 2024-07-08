import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utils.dart';

class RegisterRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signUp(String email, String password, String rool, String name,
      num phone) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore(email, rool, name, phone)})

        // ignore: body_might_complete_normally_catch_error
        .catchError((e) {
      Utils.toastMessage(e.toString());
    });
  }

  postDetailsToFirestore(
      String email, String rool, String name, num phone) async {
    try {
      var user = _auth.currentUser;
      if (user != null) {
        CollectionReference ref =
            FirebaseFirestore.instance.collection('users');
        DocumentReference userDoc = ref.doc(user.uid);
        DocumentSnapshot docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'email': email,
            'rool': rool,
            'name': name,
            'Phone': phone,
            "id": user.uid,
          });

          Utils.toastMessage("User Register Succesfully");
        }
      } else {
        Utils.toastMessage("user exist already");
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
