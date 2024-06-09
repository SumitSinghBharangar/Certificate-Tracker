import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../services/splash_services.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SplashServices splashscreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashscreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 243, 4),
      body: SafeArea(
          child: Center(
        child: Lottie.asset("assets/lotties/splash.json"),
      )),
    );
  }
}
