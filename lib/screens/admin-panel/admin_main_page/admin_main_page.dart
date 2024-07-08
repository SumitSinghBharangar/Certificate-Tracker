import 'package:flutter/material.dart';

import 'package:gla_certificate/animations/container_animation.dart';
import 'package:gla_certificate/routes/route_name.dart';
import 'package:gla_certificate/utils/colors/app_colors.dart';
import 'package:gla_certificate/utils/components/list_component.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Goodanimation(
              delay: 10,
              child: GestureDetector(
                child: ListComponent(
                  child: Container(
                    height: h * 0.2,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Student List ",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.studentListPage);
                },
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Goodanimation(
              delay: 15,
              child: GestureDetector(
                child: ListComponent(
                  child: Container(
                    height: h * 0.2,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Teacher list",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.teacherListPage);
                },
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Goodanimation(
              delay: 20,
              child: GestureDetector(
                child: ListComponent(
                  child: Container(
                    height: h * 0.2,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Add Users",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.addUserScreenPage);
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      )),
    );
  }
}
