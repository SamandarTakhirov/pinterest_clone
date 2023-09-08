import 'package:flutter/material.dart';

import '../../../common/constants/app_icons.dart';
import '../../custom_page_controller.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    openHomePage();
  }

  void openHomePage() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CustomPageController()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: size.width * 0.4,
          width: size.width * 0.4,
          child: const Image(
            image: AssetImage(AppIcons.logo),
          ),
        ),
      ),
    );
  }
}
