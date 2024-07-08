import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gla_certificate/utils/utils.dart';

import '../routes/route_name.dart';

class SplashServices {
  static isFirstTime({required BuildContext context}) async {
    final auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final user = auth.currentUser;
    bool permission = await Utils.requestPermission();
    Timer(const Duration(milliseconds: 1500), () async {
      if (permission) {
        print("permission granted");
        if (user != null) {
          _firestore
              .collection("users")
              .doc(user.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              if (documentSnapshot.get("rool") == "Teacher") {
                Navigator.pushReplacementNamed(
                    context, RoutesName.teacherhomepage);
              } else {
                Navigator.pushReplacementNamed(
                    context, RoutesName.homeScreenPage);
              }
            } else {
              Utils.flushbarerrormessage(
                  "Document does not exits on the database", context);
            }
          });
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
        }
      } else {
        await openAppSettings();
      }
    });
  }

  // FutureOr<void> islogin(BuildContext context) async {
  //   // final auth = FirebaseAuth.instance;
  //   // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //   // final user = auth.currentUser;

  // }
}
