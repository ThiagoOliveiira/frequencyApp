import 'package:flutter/material.dart';
import 'package:frequency_app/domain/domain.dart';
import 'package:get/get.dart';

import '../../ui.dart';

class ClassroomPage extends StatelessWidget {
  final ClassroomPresenter presenter;
  const ClassroomPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas aulas', style: TextStyle(color: AppColor.bluegreen600, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: const DefaultBottomNavigationBar(currentPageIndex: 1),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nova aula'),
        icon: const Icon(Icons.add),
        onPressed: () => presenter.getWifiNetworks(3120),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => presenter.isLoading.value
                ? const Center(child: CircularProgressIndicator(color: AppColor.bluegreen600))
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Text(
                            'Próximas aulas',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.bluegreen),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: presenter.aulaNotClosed.value?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              AulaEntity? aula = presenter.aulaNotClosed.value?[index];
                              return ClassroomItemComponent(aula: aula);
                            },
                          ),
                        ),
                        presenter.aulaClosed.value != null && presenter.aulaClosed.value?.isNotEmpty == true
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Text(
                                  'Aulas encerradas',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.bluegreen),
                                ),
                              )
                            : const SizedBox(),
                        presenter.aulaClosed.value != null && presenter.aulaClosed.value?.isNotEmpty == true
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: presenter.aulaClosed.value?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    AulaEntity? aula = presenter.aulaClosed.value?[index];
                                    return ClassroomItemComponent(aula: aula);
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
