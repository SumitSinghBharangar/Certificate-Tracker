import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/bloc/loginbloc/login_bloc.dart';
import 'package:gla_certificate/repositories/login_repository.dart';
import 'package:gla_certificate/routes/route_name.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = LoginBloc(loginRepo: LoginRepo());
    return Scaffold(
      appBar: AppBar(
        title: Text("login Screen"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          bloc: loginBloc,
          listenWhen: (previous, current) =>
              current.loginStatus != previous.loginStatus,
          listener: (context, state) {
            if (state.loginStatus == LoginStatus.loading) {
              Utils.flushbarerrormessage("Loading", context);
            }
            if (state.loginStatus == LoginStatus.success) {
              final user = _auth.currentUser;
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
              }
            }
            if (state.loginStatus == LoginStatus.error) {
              Utils.flushbarerrormessage("Error Occured ", context);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          decoration: const InputDecoration(
                            hintText: "Email. . .",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enter Email";
                            }
                            if (!value.endsWith("@gla.ac.in")) {
                              return "Please enter the valid Email id !";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onFieldSubmitted: (value) {},
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        TextFormField(
                          obscureText: !state.isVisible,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  loginBloc.add(EnableDisableVisibility());
                                },
                                icon: Icon(state.isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            hintText: "Password. . .",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enter Password";
                            } else if (value.length < 6) {
                              return "Please enter atleas 6 digit password";
                            }

                            return null;
                          },
                          onChanged: (value) {},
                          onFieldSubmitted: (value) {},
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (emailController.text.toString() ==
                                      "sumit@gla.ac.in") {
                                    Navigator.pushNamed(
                                        context, RoutesName.adminMainPage);
                                  } else {
                                    loginBloc.add(
                                      LoginButtonEvent(
                                        password:
                                            passwordController.text.trim(),
                                        email: emailController.text.trim(),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: state.loginStatus == LoginStatus.loading
                                  ? const CircularProgressIndicator()
                                  : const Text("Login")),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
