import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class NewClassroomPage extends StatelessWidget {
  const NewClassroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _valores = ['Direito', 'Sistemas de informação', 'Enfermagem', 'Administração'];
    var _valores2 = ['Programação', 'Redes de Computadores', 'Inteligência Artificial', 'Banco de Dados'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova aula', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              items: _valores.map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList(),
              style: const TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold),
              borderRadius: BorderRadius.circular(15),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 1, color: AppColor.bluegreen),
                ),
                label: const Text('Selecione o curso', style: TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 1, color: AppColor.bluegreen),
                ),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              items: _valores2.map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList(),
              style: const TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold),
              borderRadius: BorderRadius.circular(15),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 1, color: AppColor.bluegreen),
                ),
                label: const Text('Selecione a disciplna', style: TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 1, color: AppColor.bluegreen),
                ),
              ),
              onChanged: (value) {},
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
