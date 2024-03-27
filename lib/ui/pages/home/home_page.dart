import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../ui.dart';

class HomePage extends StatelessWidget with UIErrorManager, KeyboardManager {
  final HomePresenter presenter;
  const HomePage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const DefaultBottomNavigationBar(currentPageIndex: 0),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async => await presenter.teste(),
        //   child: Text('TESTE'),
        // ),
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
                      ? const Center(child: CircularProgressIndicator())
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
              : Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Container(
                            color: AppColor.coral400,
                            padding: const EdgeInsets.all(10),
                            child: const Row(
                              children: [
                                Text('Suas próximas aulas:'),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nome curso'),
                                  Text('Nome disciplina'),
                                  Text('Data e hora'),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Iniciar aula'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}
