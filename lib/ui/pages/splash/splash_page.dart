import 'package:flutter/material.dart';
import 'package:frequency_app/ui/ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;
  const SplashPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Image.asset('assets/images/pesquisa.png', scale: 6, color: presenter.colors.value[presenter.currentIndex.value])),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() =>
                  Text('FrequencyApp', style: GoogleFonts.exo2(fontSize: 30, fontWeight: FontWeight.bold, height: 1, color: presenter.colors.value[presenter.currentIndex.value]))),
              Obx(
                () => Text('Simplificando sua frequência',
                    style: GoogleFonts.exo2(fontSize: 15, fontWeight: FontWeight.w500, color: presenter.colors.value[presenter.currentIndex.value]?.withOpacity(0.3))),
              ),
              const SizedBox(height: 2)
            ],
          ),
        ],
      )),
    );
  }
}
