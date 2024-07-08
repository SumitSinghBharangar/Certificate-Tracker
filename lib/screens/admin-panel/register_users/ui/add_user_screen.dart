import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/repositories/register_repository.dart';
import 'package:gla_certificate/screens/admin-panel/register_users/bloc/register_bloc.dart';
import 'package:gla_certificate/utils/colors/app_colors.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/utils.dart';

class AddUserScreenPage extends StatefulWidget {
  const AddUserScreenPage({super.key});

  @override
  State<AddUserScreenPage> createState() => _AddUserScreenPage();
}

class _AddUserScreenPage extends State<AddUserScreenPage> { 
  final _formkey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailfocusnode = FocusNode();
  final FocusNode nameFocusnode = FocusNode();
  final FocusNode mobileFocusnode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailfocusnode.dispose();
    passwordFocusNode.dispose();
  }

  File? file;
  var options = [
    'Student',
    'Teacher',
  ];
  var _currentItemSelected = "Student";
  var rool = "Student";

  @override
  Widget build(BuildContext context) {
    RegisterBloc registerBloc = RegisterBloc(registerRepo: RegisterRepo());
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          listenWhen: (previous, current) =>
              current.registerStatus != previous.registerStatus,
          listener: (context, state) {
            if (state.registerStatus == RegisterStatus.loading) {
              const Center(child: CircularProgressIndicator());
            }
            if (state.registerStatus == RegisterStatus.error) {
              const Center(
                child: Text("Something went Wrong"),
              );
            }
            if (state.registerStatus == RegisterStatus.success) {
              Utils.snakbar("User registered successfully", context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h * 0.1,
                      ),
                      const Text(
                        "Register Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(
                        height: h * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.person_outline),
                          SizedBox(
                            width: w * 0.08,
                          ),
                          SizedBox(
                            width: w * 0.7,
                            child: TextFormField(
                              focusNode: nameFocusnode,
                              controller: nameController,
                              decoration: const InputDecoration(
                                hintText: "Name. . .",
                                label: Text("Name "),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter the name !";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                Utils.fieldfocuschange(
                                    context, nameFocusnode, emailfocusnode);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.040,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.email),
                          SizedBox(
                            width: w * 0.08,
                          ),
                          SizedBox(
                            width: w * 0.7,
                            child: TextFormField(
                              focusNode: emailfocusnode,
                              controller: emailController,
                              decoration: const InputDecoration(
                                label: Text("Email ."),
                                hintText: "Email. . .",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email enter the email";
                                }
                                if (!value.endsWith("@gla.ac.in")) {
                                  return "Please enter the valid Email id !";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                Utils.fieldfocuschange(
                                    context, emailfocusnode, passwordFocusNode);
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock),
                          SizedBox(
                            width: w * 0.08,
                          ),
                          SizedBox(
                            width: w * 0.7,
                            child: TextFormField(
                              focusNode: passwordFocusNode,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  label: Text("Password ."),
                                  hintText: "Password. . .",
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter the password !";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                Utils.fieldfocuschange(context,
                                    passwordFocusNode, mobileFocusnode);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phone),
                          SizedBox(
                            width: w * 0.08,
                          ),
                          SizedBox(
                            width: w * 0.7,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              focusNode: mobileFocusnode,
                              controller: mobileController,
                              decoration: const InputDecoration(
                                  label: Text("Phone No"),
                                  hintText: "Phone No",
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter the name !";
                                }
                                String pattern = r'^[0-9]{10}$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Please enter a valid 10-digit mobile number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Rool : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: w * 0.03,
                          ),
                          DropdownButton<String>(
                            isDense: true,
                            isExpanded: false,
                            items: options.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: const TextStyle(
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
                        height: h * 0.04,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.92,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              registerBloc.add(
                                RegisterButtonEvent(
                                    password: passwordController.text.trim(),
                                    email: emailController.text.trim(),
                                    rool: rool.toString(),
                                    name: nameController.text.trim(),
                                    phone: num.parse(
                                        mobileController.text.trim())),
                              );
                              controllerdispose();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: blueShade,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: state.registerStatus == RegisterStatus.loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  "Register",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void controllerdispose() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    mobileController.clear();
  }
}
