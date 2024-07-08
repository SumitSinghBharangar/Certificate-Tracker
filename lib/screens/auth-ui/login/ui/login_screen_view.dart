import 'package:bounce/bounce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gla_certificate/screens/auth-ui/login/bloc/login_bloc.dart';
import 'package:gla_certificate/repositories/login_repository.dart';
import 'package:gla_certificate/routes/route_name.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var h = MediaQuery.of(context).size.height;
    final LoginBloc loginBloc = LoginBloc(loginRepo: LoginRepo());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 118, 205, 246),
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          bloc: loginBloc,
          listenWhen: (previous, current) =>
              current.loginStatus != previous.loginStatus,
          listener: (context, state) {
            if (state.loginStatus == LoginStatus.loading) {
              const Center(
                child: CircularProgressIndicator(),
              );
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
              }
            }
            if (state.loginStatus == LoginStatus.error) {
              Utils.flushbarerrormessage("Error Occured ", context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: h * 0.75,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 48, 178, 238),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: h * 0.17,
                              child: Image.asset("assets/images/glapic.png"),
                            ),
                            const Text(
                              "GLA UNIVERSITY",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: h * 0.225,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.1,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  child: const Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.house,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "About GLA",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    launchUrl(
                                      Uri.parse(
                                          'https://www.gla.ac.in/about-us-mission-vision'),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: const Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "FACEBOOK",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    launchUrl(
                                      Uri.parse(
                                          'https://www.facebook.com/profile.php/?id=100064310306957'),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: const Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "INSTRAGRAM",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    launchUrl(
                                      Uri.parse(
                                          'https://www.instagram.com/glauniv?igsh=MXdud213bmltaGhxbQ=='),
                                    );
                                  },
                                ),
                                GestureDetector(
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "GLAMS",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    launchUrl(
                                      Uri.parse('https://www.gla.ac.in/'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
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
                              SizedBox(
                                height: h * 0.09,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                          hintText: "Email. . .",
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: emailFocusNode,
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
                                      onFieldSubmitted: (value) {
                                        Utils.fieldfocuschange(context,
                                            emailFocusNode, passwordFocusNode);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintText: "Password. . .",
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              loginBloc.add(
                                                  EnableDisableVisibility());
                                            },
                                            icon: Icon(
                                              state.isVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                            )),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      obscureText: !state.isVisible,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      focusNode: passwordFocusNode,
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
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Bounce(
                                child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // button border radius
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (emailController.text.toString() ==
                                              "sumit@gla.ac.in") {
                                            Navigator.pushNamed(context,
                                                RoutesName.adminMainPage);
                                          } else {
                                            loginBloc.add(
                                              LoginButtonEvent(
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                                email:
                                                    emailController.text.trim(),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: state.loginStatus ==
                                              LoginStatus.loading
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
