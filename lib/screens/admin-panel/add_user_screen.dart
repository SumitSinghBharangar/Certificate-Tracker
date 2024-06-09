import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gla_certificate/utils/utils.dart';

// import 'model.dart';

class AddUserScreenPage extends StatefulWidget {
  const AddUserScreenPage({super.key});

  @override
  State<AddUserScreenPage> createState() => _AddUserScreenPage();
}

class _AddUserScreenPage extends State<AddUserScreenPage> {
  _AddUserScreenPage();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  File? file;
  var options = [
    'Student',
    'Teacher',
  ];
  var _currentItemSelected = "Student";
  var rool = "Student";

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: h * 0.3,
              left: w * 0.4,
              child: Icon(Icons.home),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Register Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          label: Text(
                        "Email.",
                        style: TextStyle(color: Colors.black),
                      )),
                      validator: (value) {
                        if (value!.length == 0) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please enter a valid email");
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          label: Text(
                        "Password",
                        style: TextStyle(color: Colors.black),
                      )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rool : ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        DropdownButton<String>(
                          dropdownColor: Colors.blue[900],
                          // isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Colors.white,
                          focusColor: Colors.white,
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected!;
                              rool = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      height: 40,
                      onPressed: () {
                        setState(() {
                          showProgress = true;
                        });
                        signUp(emailController.text, passwordController.text,
                            rool);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          
          // ignore: body_might_complete_normally_catch_error
          .catchError((e) {
        Utils.flushbarerrormessage(e.toString(), context);
      });
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
    
  }
}
