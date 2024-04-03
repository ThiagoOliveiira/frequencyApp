import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../domain/domain.dart';
import '../../../theme/theme.dart';
import '../../../utils/string_utils.dart';
import '../../pages.dart';

class ClassroomItemComponent extends StatelessWidget {
  final AulaEntity? aula;
  const ClassroomItemComponent({super.key, required this.aula});

  @override
  Widget build(BuildContext context) {
    GlobalKey slideKey = GlobalKey();
    final presenter = Get.find<ClassroomPresenter>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Slidable(
        key: slideKey,
        enabled: aula?.finalizada == false && aula?.dataAula?.difference(DateTime.now()).inDays == 0,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.38,
          children: [
            aula?.iniciada != true
                ? SlidableAction(
                    onPressed: (context) async => await presenter.startClass(aula),
                    backgroundColor: AppColor.green300,
                    foregroundColor: Colors.white,
                    icon: Icons.play_arrow,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    label: 'Iniciar aula',
                  )
                : const SizedBox(),
            aula?.finalizada == false && aula?.iniciada == true
                ? SlidableAction(
                    onPressed: (context) async => await presenter.endClass(aula),
                    backgroundColor: AppColor.grey900,
                    foregroundColor: Colors.white,
                    icon: Icons.close,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    label: 'Finalizar aula',
                  )
                : const SizedBox(),
          ],
        ),
        child: ListTile(
          onTap: aula?.iniciada == true ? () => Get.to(() => ClassroomCodePage(aulaEntity: aula!)) : null,
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: AppColor.grey300, shape: BoxShape.circle),
            child: const Icon(Icons.class_outlined),
          ),
          iconColor: AppColor.bluegreen,
          style: ListTileStyle.list,
          title: Text(aula?.nomeCurso ?? 'Não informado', style: const TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold)),
          subtitle: Text(aula?.nomeDisciplina ?? 'Não informado', style: const TextStyle(color: AppColor.bluegreen600)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(handleDataTimeDay(aula?.dataAula, iniciada: aula?.iniciada, finalizada: aula?.finalizada) ?? '',
                  style: const TextStyle(color: AppColor.bluegreen600, fontWeight: FontWeight.bold)),
              Text(handleDataTimeHour(aula?.dataAula) ?? '', style: const TextStyle(color: AppColor.bluegreen600))
            ],
          ),
          tileColor: aula?.iniciada == true && aula?.finalizada == false ? AppColor.bluegreen600.withOpacity(0.1) : null,
        ),
      ),
    );
  }
}
