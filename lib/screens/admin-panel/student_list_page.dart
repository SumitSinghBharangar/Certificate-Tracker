import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentListPageScreen extends StatefulWidget {
  const StudentListPageScreen({super.key});

  @override
  State<StudentListPageScreen> createState() => _StudentListPageScreenState();
}

class _StudentListPageScreenState extends State<StudentListPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student List Page "),
      ),
    );
  }
}