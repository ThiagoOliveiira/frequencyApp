import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frequency_app/ui/ui.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget with UIErrorManager, KeyboardManager {
  final LoginPresenter presenter;
  const LoginPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('FrequencyApp', style: TextStyle(color: AppColor.bluegreen, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                SvgPicture.asset('assets/icons/check-square.svg', color: AppColor.bluegreen, height: MediaQuery.of(context).size.width * .08),
              ],
            ),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        handleMainError(context, presenter.mainError, 'Ops!');

        return GestureDetector(
          onTap: () => hideKeyboard(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: kBottomNavigationBarHeight * 2),
                const SizedBox(height: kBottomNavigationBarHeight),
                const Align(alignment: Alignment.centerLeft, child: Text('Login', style: TextStyle(color: AppColor.bluegreen, fontSize: 22, fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 8,
                  initialValue: '17544304',
                  decoration: InputDecoration(
                    counter: const SizedBox(),
                    hintText: 'Matricula',
                    hintStyle: const TextStyle(color: AppColor.bluegreen),
                    prefixIcon: const Icon(Icons.person, color: AppColor.bluegreen),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                    errorText: presenter.matriculaError.value?.description,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: presenter.validateMatricula,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  initialValue: 'senha098',
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: AppColor.bluegreen),
                    labelStyle: const TextStyle(color: AppColor.bluegreen),
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock, color: AppColor.bluegreen),
                    hintText: 'Senha',
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                    errorText: presenter.senhaError.value?.description,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: presenter.validateSenha,
                ),
                // const SizedBox(height: kBottomNavigationBarHeight * 2),
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
                          children: const [
                            Spacer(),
                            Text('Acessar conta', style: TextStyle(color: AppColor.white, fontSize: 18)),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios, color: AppColor.white),
                          ],
                        ),
                      )),
                const SizedBox(height: kBottomNavigationBarHeight),
              ],
            ),
          ),
        );
      }),
    );
  }
}
