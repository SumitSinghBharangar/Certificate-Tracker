import 'package:flutter/material.dart';
import 'package:gla_certificate/screens/admin-panel/add_user_screen.dart';
import 'package:gla_certificate/screens/admin-panel/admin_main_page.dart';
import 'package:gla_certificate/screens/admin-panel/student_list_page.dart';
import 'package:gla_certificate/screens/admin-panel/teacher_list_page.dart';
import 'package:gla_certificate/screens/auth-ui/login_screen_view.dart';
import 'package:gla_certificate/screens/auth-ui/splash_page.dart';
import 'package:gla_certificate/screens/user-panel/student_panel/homescreen.dart';
import 'package:gla_certificate/screens/user-panel/student_panel/upload_document_page.dart';
import 'package:gla_certificate/screens/user-panel/teacher_panel/teacher_home_page.dart';

import 'route_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: ((context) => const Splash()));
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: ((context) => const LoginScreen()));
      case RoutesName.adminMainPage:
        return MaterialPageRoute(builder: ((context) => const AdminMainPage()));
      case RoutesName.teacherListPage:
        return MaterialPageRoute(
            builder: ((context) => const TeacherListPageScreen()));
      case RoutesName.studentListPage:
        return MaterialPageRoute(
            builder: ((context) => const StudentListPageScreen()));
      case RoutesName.homeScreenPage:
        return MaterialPageRoute(
            builder: ((context) => const HomeScreenPage()));
      case RoutesName.addUserScreenPage:
        return MaterialPageRoute(
            builder: ((context) => const AddUserScreenPage()));
      case RoutesName.teacherhomepage:
        return MaterialPageRoute(builder: ((context) => const THomePage()));
      case RoutesName.fileUploadPage:
        return MaterialPageRoute(
            builder: ((context) => const UploadDocumentScreen()));

      default:
        return MaterialPageRoute(builder: ((context) {
          return const Scaffold(
            body: Center(
              child: Text("No Route generated !"),
            ),
          );
        }));
    }
  }
}
