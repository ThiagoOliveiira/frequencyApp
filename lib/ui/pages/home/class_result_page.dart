import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../ui.dart';

class ClassResultPage extends StatelessWidget {
  const ClassResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<HomePresenter>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirme sua presença', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: presenter.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(presenter.aulaEntity.value?.codigoAula ?? '', style: const TextStyle(fontSize: 27, color: AppColor.green400, fontWeight: FontWeight.bold)),
                                Chip(
                                  label: const Text('Iniciada', style: TextStyle(color: AppColor.bluegreen600)),
                                  avatar: const Icon(Icons.class_, color: AppColor.green400),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: AppColor.coral,
                                      width: 2,
                                      strokeAlign: 2,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ItemCardClass(
                              title: 'Curso:',
                              description: presenter.aulaEntity.value?.nomeCurso ?? 'N/I',
                            ),
                            ItemCardClass(
                              title: 'Disciplina:',
                              description: presenter.aulaEntity.value?.nomeDisciplina ?? 'N/I',
                            ),
                            presenter.aulaEntity.value?.dataAula != null
                                ? ItemCardClass(title: 'Data da aula:', description: DateFormat('dd/MM - HH:mm').format(presenter.aulaEntity.value!.dataAula!))
                                : const SizedBox(),
                            ItemCardClass(
                              title: 'Professor:',
                              description: presenter.aulaEntity.value?.nomeProfessor ?? 'N/I',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => presenter.confirmPresence(),
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(AppColor.bluegreen600),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                        overlayColor: MaterialStatePropertyAll(AppColor.bluegreen600),
                        padding: MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: 10))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Confirmar presença', style: TextStyle(color: AppColor.white, fontSize: 18)),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class ItemCardClass extends StatelessWidget {
  final String title;
  final String description;

  const ItemCardClass({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.bluegreen600),
            ),
          ),
          const SizedBox(width: 5),
          Text(description, maxLines: 3, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.bluegreen)),
        ],
      ),
    );
  }
}
