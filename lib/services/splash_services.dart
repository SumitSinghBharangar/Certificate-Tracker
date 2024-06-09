import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:gla_certificate/utils/utils.dart';

import '../routes/route_name.dart';

class SplashServices {
  FutureOr<void> islogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final user = auth.currentUser;

    if (user != null) {
      _firestore
          .collection("users")
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get("rool") == "Teacher") {
            Timer(const Duration(milliseconds: 3000), () {
              Navigator.pushReplacementNamed(
                  context, RoutesName.teacherhomepage);
            });
          } else {
            Timer(const Duration(milliseconds: 3000), () {
              Navigator.pushReplacementNamed(
                  context, RoutesName.homeScreenPage);
            });
          }
        } else {
          Utils.flushbarerrormessage(
              "Document does not exits on the database", context);
        }
      });
    } else {
      Timer(const Duration(milliseconds: 3000), () {
        Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
      });
    }
  }
}
