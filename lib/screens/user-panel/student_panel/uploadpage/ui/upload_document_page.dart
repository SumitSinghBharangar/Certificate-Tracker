import 'dart:io';

import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/screens/user-panel/student_panel/uploadpage/block/upload_page_bloc.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/utils.dart';
import 'package:intl/intl.dart';

import '../block/upload_page_event.dart';
import '../block/upload_page_state.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  File? document;

  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode startdateFocusNode = FocusNode();
  FocusNode enddateFocusNode = FocusNode();
  FocusNode typeFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    UploadBloc uploadBloc = UploadBloc();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Document here"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    focusNode: nameFocusNode,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text("name"),
                      hintText: "Name of document",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter the name of document";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      Utils.fieldfocuschange(
                          context, nameFocusNode, typeFocusNode);
                    },
                  ),
                  SizedBox(
                    height: h * 0.05,
                  ),
                  TextFormField(
                    controller: typeController,
                    focusNode: typeFocusNode,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text("Type"),
                      hintText: "Type of document",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter the type of document";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      Utils.fieldfocuschange(
                          context, typeFocusNode, startdateFocusNode);
                    },
                  ),
                  SizedBox(
                    height: h * 0.05,
                  ),
                  TextFormField(
                    controller: startdateController,
                    focusNode: startdateFocusNode,
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text("Start Date"),
                      hintText: "Select the start date",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please select the start date";
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        initialDate: DateTime.now(),
                      );
                      if (pickedDate == null) return;
                      startdateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    },
                    onFieldSubmitted: (value) {
                      Utils.fieldfocuschange(
                          context, startdateFocusNode, enddateFocusNode);
                    },
                  ),
                  SizedBox(
                    height: h * 0.05,
                  ),
                  TextFormField(
                    controller: enddateController,
                    focusNode: enddateFocusNode,
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text("End Date"),
                      hintText: "Select the end date",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please select the end date";
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        initialDate: DateTime.now(),
                      );
                      if (pickedDate == null) return;
                      enddateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    },
                  ),
                  SizedBox(
                    height: h * 0.05,
                  ),
                  BlocConsumer<UploadBloc, UploadState>(
                    bloc: uploadBloc,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.file == null) {
                        return Bounce(
                          child: Container(
                            width: w * 0.9,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(11)),
                            child: const Center(child: Text("Pick Document")),
                          ),
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              uploadBloc.add(PickDocumentEvent());
                            } else {
                              return "plese fill the details of document";
                            }
                          },
                        );
                      } else {
                        document = state.file;
                        return Column(
                          children: [
                            Container(
                              height: 40,
                              width: w * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Center(
                                child: Text(
                                  state.file!.path.toString(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.07,
                            ),
                            Bounce(
                              child: Container(
                                width: w * 0.9,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Center(
                                    child: state.uploadStatus ==
                                            UploadStatus.loading
                                        ? const CircularProgressIndicator()
                                        : const Text("Upload")),
                              ),
                              onTap: () {
                                print("document uploading");
                               
                                uploadBloc.add(UploadDocumentEvent(
                                  file: document!,
                                  name: nameController.text.trim(),
                                  enddate: DateFormat('yyyy-MM-dd')
                                      .parseStrict(enddateController.text),
                                  startdate: DateFormat('yyyy-MM-dd')
                                      .parseStrict(startdateController.text),
                                  type: typeController.text.trim(),
                                ));
                                controllerClear();
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void controllerClear() {
    nameController.clear();
    startdateController.clear();
    typeController.clear();
    enddateController.clear();
  }
}
