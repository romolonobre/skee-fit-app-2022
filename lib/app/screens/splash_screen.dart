import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../skee_ui/skee_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Modular.to.pushNamedAndRemoveUntil(
          '/home/', (route) => route.settings.name == '/home/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: WEPalette.cardColor,
        child: Center(
          child: Image.asset(
            'assets/skeefit_1_1.png',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
