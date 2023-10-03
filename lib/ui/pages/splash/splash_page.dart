import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frequency_app/ui/ui.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;
  const SplashPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bluegreen,
      body: Center(child: SvgPicture.asset('assets/icons/check-square.svg', color: Colors.white)),
    );
  }
}
