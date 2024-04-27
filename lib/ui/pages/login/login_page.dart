import 'package:flutter/material.dart';
import 'package:frequency_app/ui/ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget with UIErrorManager, KeyboardManager {
  final LoginPresenter presenter;
  const LoginPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        handleMainError(context, presenter.mainError, 'Ops!');
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => hideKeyboard(context),
              child: Container(
                height: Get.size.height,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kBottomNavigationBarHeight * 2),
                    Image.asset('assets/images/pesquisa.png', scale: 5, color: AppColor.bluegreen600),
                    Column(
                      children: [
                        Text('FrequencyApp', style: GoogleFonts.exo2(fontSize: 20, fontWeight: FontWeight.bold, height: 1)),
                        Text('Simplificando sua frequência', style: GoogleFonts.exo2(fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.bluegreen)),
                      ],
                    ),
                    const SizedBox(height: kBottomNavigationBarHeight),
                    Align(alignment: Alignment.centerLeft, child: Text('Login', style: GoogleFonts.exo2(color: AppColor.bluegreen, fontSize: 22, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLength: 8,
                      decoration: InputDecoration(
                        counter: const SizedBox(),
                        hintText: 'Matricula',
                        hintStyle: GoogleFonts.exo2(color: AppColor.bluegreen),
                        prefixIcon: const Icon(Icons.person, color: AppColor.bluegreen),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                        errorText: presenter.registrationError.value?.description,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: presenter.validateRegistration,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.exo2(color: AppColor.bluegreen),
                        labelStyle: GoogleFonts.exo2(color: AppColor.bluegreen),
                        alignLabelWithHint: true,
                        prefixIcon: const Icon(Icons.lock, color: AppColor.bluegreen),
                        hintText: 'Senha',
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                        errorText: presenter.passwordError.value?.description,
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: presenter.validatePassword,
                    ),
                    const Spacer(),
                    Obx(() => presenter.isLoading.value
                        ? const CircularProgressIndicator(color: AppColor.bluegreen)
                        : TextButton(
                            onPressed: presenter.isFormValid.value ? () async => await presenter.auth() : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(presenter.isFormValid.value ? AppColor.bluegreen : AppColor.grey500),
                              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                              overlayColor: const MaterialStatePropertyAll(AppColor.bluegreen600),
                              padding: const MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: 10))),
                            ),
                            child: Row(
                              children: [
                                const Spacer(),
                                Text('Acessar conta', style: GoogleFonts.exo2(color: AppColor.white, fontSize: 18)),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios, color: AppColor.white),
                              ],
                            ),
                          )),
                    const SizedBox(height: kBottomNavigationBarHeight),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
