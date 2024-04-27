import 'package:flutter/material.dart';
import 'package:frequency_app/ui/ui.dart';
import 'package:get/get.dart';

import '../../../domain/domain.dart';

class FrequencyPage extends StatelessWidget {
  final AulaEntity? aulaEntity;

  const FrequencyPage({super.key, required this.aulaEntity});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<ClassroomPresenter>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Frequência', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blueGrey[100],
          surfaceTintColor: Colors.white,
          actions: [IconButton(onPressed: () async => await presenter.getStudentFrequencyList(aulaEntity?.id), icon: const Icon(Icons.refresh_rounded))],
        ),
        body: Obx(
          () => presenter.isLoading.value
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: presenter.frequencyClass.value?.length,
                  itemBuilder: (context, index) {
                    StudentFrequencyEntity? frequency = presenter.frequencyClass.value?[index];
                    return ExpansionTile(
                      leading: Column(children: [Checkbox(value: true, onChanged: (value) {}, activeColor: Colors.green)]),
                      subtitle: const Text('01/01/2024 as 19:35'),
                      title: Text(frequency?.nomeAluno ?? ''),
                      childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                      children: const [
                        ItemCardClass(title: 'Matricula', description: '123456'),
                        ItemCardClass(title: 'id aula', description: '123'),
                      ],
                    );
                  },
                ),
        ));
  }
}
