import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherListPageScreen extends StatefulWidget {
  const TeacherListPageScreen({super.key});

  @override
  State<TeacherListPageScreen> createState() => _TeacherListPageScreenState();
}

class _TeacherListPageScreenState extends State<TeacherListPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher List Page Screen"),
      ),
    );
  }
}
