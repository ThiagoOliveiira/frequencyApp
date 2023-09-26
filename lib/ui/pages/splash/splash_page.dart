import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frequency_app/ui/ui.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) => Get.offAndToNamed('/login'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bluegreen,
      body: Center(child: SvgPicture.asset('assets/icons/check-square.svg', color: Colors.white)),
    );
  }
}
