import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frequency_app/ui/pages/nearby/nearby_page.dart';
import 'package:frequency_app/ui/utils/string_utils.dart';
import 'package:get/get.dart';

import '../../../domain/domain.dart';
import '../../ui.dart';

class HomePage extends StatelessWidget with UIErrorManager, KeyboardManager {
  final HomePresenter presenter;
  const HomePage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const DefaultBottomNavigationBar(currentPageIndex: 0),
        floatingActionButton: FloatingActionButton(onPressed: () => Get.to(() => const Body())),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[100],
          surfaceTintColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FrequencyApp', style: TextStyle(color: AppColor.blue800, fontSize: 12, fontWeight: FontWeight.bold)),
              Text(presenter.accountEntity.value?.nome ?? '', style: const TextStyle(color: AppColor.bluegreen, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () async => await presenter.logout(),
                borderRadius: BorderRadius.circular(50),
                splashColor: AppColor.bege,
                child: SvgPicture.asset('assets/icons/logout.svg', color: AppColor.bluegreen),
              ),
            ),
          ],
        ),
        body: Obx(() {
          handleMainError(context, presenter.mainError, 'Ops!');
          return presenter.userType.value == UserType.aluno
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: presenter.isLoading.value
                      ? const Center(child: CircularProgressIndicator(color: AppColor.bluegreen600))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            TextField(
                              textCapitalization: TextCapitalization.sentences,
                              onSubmitted: presenter.isFormValid.value ? (_) async => await presenter.requestClassByCode() : null,
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Código da aula',
                                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: AppColor.bluegreen), borderRadius: BorderRadius.all(Radius.circular(15))),
                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(15))),
                                  border: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(15))),
                                  floatingLabelStyle: TextStyle(color: presenter.codeClassError.value != null ? Colors.red : AppColor.bluegreen, fontWeight: FontWeight.w600),
                                  errorText: presenter.codeClassError.value?.description,
                                  counter: const SizedBox(),
                                  labelStyle: const TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.w600)),
                              maxLength: 8,
                              onChanged: presenter.validateCodeClass,
                            ),
                            // StreamBuilder<List<ScanResult>>(
                            //   stream: presenter.scanResults,
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       return ListView.builder(
                            //         itemCount: snapshot.data?.length,
                            //         shrinkWrap: true,
                            //         itemBuilder: (context, index) {
                            //           final data = snapshot.data![index];
                            //           return SizedBox();
                            //         },
                            //       );
                            //     } else {
                            //       return const SizedBox();
                            //     }
                            //   },
                            // ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: presenter.isFormValid.value ? () async => await presenter.requestClassByCode() : null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(presenter.isFormValid.value ? AppColor.bluegreen : AppColor.grey500),
                                shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                overlayColor: const MaterialStatePropertyAll(AppColor.bluegreen600),
                                padding: const MaterialStatePropertyAll((EdgeInsets.symmetric(vertical: 15, horizontal: 10))),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Consultar', style: TextStyle(color: AppColor.white, fontSize: 18)),
                                ],
                              ),
                            ),
                            const SizedBox(height: kBottomNavigationBarHeight),
                          ],
                        ),
                )
              : presenter.isLoading.value
                  ? const Center(child: CircularProgressIndicator(color: AppColor.bluegreen600))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text('Professor, estas são suas\npróximas aulas:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.bluegreen600)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: presenter.aulas.value?.isNotEmpty == true ? 4 : 0,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 20),
                            itemBuilder: (context, index) {
                              AulaEntity? aula = presenter.aulas.value?[index];
                              return Container(
                                margin: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100]?.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                      decoration: const BoxDecoration(color: AppColor.bluegreen, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                                      child: Row(children: [Text(aula?.nomeDisciplina ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                      child: Column(
                                        children: [
                                          ItemCardHome(title: 'Professor:', description: aula?.nomeProfessor),
                                          ItemCardHome(title: 'Curso:', description: aula?.nomeCurso),
                                          ItemCardHome(title: 'Disciplina:', description: aula?.nomeDisciplina),
                                          ItemCardHome(
                                              title: 'Data:',
                                              description: "${handleDataTimeDay(aula?.dataAula, iniciada: aula?.iniciada, finalizada: aula?.finalizada)} às ${handleDataTimeHour(aula?.dataAula)}"),
                                        ],
                                      ),
                                    ),
                                    aula?.dataAula?.difference(DateTime.now()).inDays == 0 && aula?.iniciada != true
                                        ? InkWell(
                                            highlightColor: AppColor.bluegreen,
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(5)),
                                            onTap: () async => await presenter.startClass(aula),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 3, top: 3),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[600],
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(5)),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text('Iniciar aula', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                                    SizedBox(width: 5),
                                                    Icon(Icons.play_arrow_rounded, color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : aula?.iniciada == true
                                            ? InkWell(
                                                onTap: aula?.iniciada == true ? () => Get.to(() => ClassroomCodePage(aulaEntity: aula!)) : null,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 3, top: 3),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                    decoration: const BoxDecoration(
                                                      color: AppColor.blue800,
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(5)),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text('Aula em andamento', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                                        SizedBox(width: 5),
                                                        Icon(Icons.hourglass_bottom_rounded, color: Colors.white),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox()
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
        }),
      ),
    );
  }
}

// String? handleDataTimeDay(DateTime? dataAula, {bool? iniciada, bool? finalizada}) {
//   int currentDay = DateTime.now().day;
//   if (dataAula != null) {
//     if (iniciada == true && finalizada != true) {
//       return 'Iniciada';
//     } else if (finalizada == true) {
//       return 'Encerrada';
//     } else {
//       if (dataAula.day == currentDay) {
//         return 'Hoje';
//       } else {
//         return 'Dia ${handleDate(dataAula.day)}/${handleDate(dataAula.month)}';
//       }
//     }
//   }
//   return null;
// }

// String? handleDate(int? info) {
//   if (info != null) {
//     if (info >= 0 && info <= 9) {
//       return '0$info';
//     }
//     return info.toString();
//   }
//   return null;
// }

class ItemCardHome extends StatelessWidget {
  final String title;
  final String? description;

  const ItemCardHome({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          Text(description ?? 'N/I'),
        ],
      )
    ]);
  }
}
