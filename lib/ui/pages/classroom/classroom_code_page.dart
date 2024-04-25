import 'package:flutter/material.dart';
import 'package:frequency_app/domain/domain.dart';
import 'package:frequency_app/main/factories/factories.dart';
import 'package:get/get.dart';

import '../../ui.dart';

class ClassroomCodePage extends StatelessWidget {
  final AulaEntity? aulaEntity;
  const ClassroomCodePage({super.key, required this.aulaEntity});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.isRegistered<ClassroomPresenter>() ? Get.find<ClassroomPresenter>() : Get.put<ClassroomPresenter>(makeGetxClassroomPresenter());
    return Scaffold(
      appBar: AppBar(
        title: Text(aulaEntity?.finalizada == true ? 'Aula encerrada' : 'Aula iniciada', style: const TextStyle(color: AppColor.bluegreen600, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey[100],
        surfaceTintColor: Colors.white,
      ),
      bottomNavigationBar: const DefaultBottomNavigationBar(currentPageIndex: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => presenter.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: AppColor.bluegreen600))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            DescriptionComponent(title: 'Curso', description: aulaEntity?.nomeCurso),
                            const SizedBox(height: 10),
                            DescriptionComponent(title: 'Disciplina', description: aulaEntity?.nomeDisciplina),
                          ],
                        ),
                        InkWell(
                          onTap: () => Get.to(() => FrequencyPage(aulaEntity: aulaEntity)),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.lightGreen,
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.checklist, size: 30),
                                Text(
                                  'Frequência',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(aulaEntity?.finalizada == true ? 'Esta aula já foi encerrada' : 'Informe o código abaixo para os alunos:', style: const TextStyle(fontSize: 15)),
                            aulaEntity?.finalizada == true
                                ? const SizedBox()
                                : Text(aulaEntity?.codigoAula ?? '', style: TextStyle(fontSize: Get.size.width * 0.12, fontWeight: FontWeight.bold, color: AppColor.green400)),
                            const SizedBox(height: kBottomNavigationBarHeight * 2),
                            aulaEntity?.finalizada == false
                                ? TextButton(
                                    onPressed: () async {
                                      await presenter.endClass(aulaEntity);
                                      Get.back(closeOverlays: true);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: const MaterialStatePropertyAll(AppColor.bluegreen),
                                      shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                      overlayColor: const MaterialStatePropertyAll(AppColor.bluegreen600),
                                      padding: MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: Get.size.width * 0.1))),
                                    ),
                                    child: const Text('Encerrar aula', style: TextStyle(color: AppColor.white, fontSize: 18)),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 15),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.info, color: Colors.red),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text('Uma vez encerrada a aula, nenhum estudante poderá mais validar sua presença.',
                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 14, color: AppColor.bluegreen600, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
        ),
      ),
    );
  }
}

class DescriptionComponent extends StatelessWidget {
  final String? title;
  final String? description;
  const DescriptionComponent({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? ''),
        Text(description ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.bluegreen600)),
      ],
    );
  }
}
