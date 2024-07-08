import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static void fieldfocuschange(
      BuildContext context, FocusNode current, FocusNode nextfocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void flushbarerrormessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        borderRadius: BorderRadius.circular(11),
        duration: const Duration(milliseconds: 4000),
        forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        reverseAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        animationDuration: const Duration(milliseconds: 3000),
        positionOffset: 20,
        messageColor: Colors.white,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.deepPurple,
      )..show(context),
    );
  }

  static snakbar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      backgroundColor: Colors.black,
    ));
  }

  static Future<bool> requestPermission() async {
    var status1 = await Permission.storage.status;

    if (status1.isGranted) {
      return true;
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();
      var temp1 = await Permission.storage.status;
      var manageStorageStatus = await Permission.manageExternalStorage.status;
      if (temp1.isGranted || manageStorageStatus.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
