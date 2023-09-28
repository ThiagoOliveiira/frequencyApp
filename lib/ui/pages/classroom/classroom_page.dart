import 'package:flutter/material.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
                onTap: () => Get.to(() => const NewClassroomPage()), borderRadius: BorderRadius.circular(50), splashColor: AppColor.bege, child: const Icon(Icons.add, color: AppColor.bluegreen600)),
          ),
        ],
      ),
      bottomNavigationBar: const DefaultBottomNavigationBar(currentPageIndex: 1),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nova aula'),
        icon: const Icon(Icons.add),
        onPressed: () => Get.to(() => const NewClassroomPage()),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: AppColor.grey300, shape: BoxShape.circle),
              child: const Icon(Icons.class_outlined),
            ),
            iconColor: AppColor.bluegreen,
            title: const Text('Sistemas de informação', style: TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold)),
            subtitle: const Text('Banco de dados', style: TextStyle(color: AppColor.bluegreen600)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [Text('Hoje', style: TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold)), Text('19:00', style: TextStyle(color: AppColor.bluegreen600))],
            ),
          )
        ],
      ),
    );
  }
}
