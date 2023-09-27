import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class NewClassroomPage extends StatelessWidget {
  const NewClassroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova aula', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: AppColor.bluegreen),
                labelStyle: TextStyle(color: AppColor.bluegreen),
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.lock, color: AppColor.bluegreen),
                hintText: 'Senha',
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                // errorText: presenter.senhaError.value?.description,
              ),
              keyboardType: TextInputType.number,
              // onChanged: presenter.validateSenha,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColor.bluegreen),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                overlayColor: MaterialStatePropertyAll(AppColor.bluegreen600),
                padding: MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: 10))),
              ),
              child: const Row(
                children: [
                  Spacer(),
                  Text('Criar Aula', style: TextStyle(color: AppColor.white, fontSize: 18)),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
