import 'dart:ffi';

import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';
import '../mixins/mixins.dart';

class GetxClassroomPresenter extends GetxController with LoadingManager implements ClassroomPresenter {
  final ClassroomUsecase classroomUsecase;
  final LoadCurrentAccount loadCurrentAccount;

  GetxClassroomPresenter({required this.classroomUsecase, required this.loadCurrentAccount});

  @override
  Rx<AccountEntity?> accountEntity = Rx(null);

  @override
  Rx<List<AulaEntity>?> aulaEntity = Rx(null);

  @override
  void onInit() async {
    await loadUserInfo();
    await _loadAulasByIdProfessor();
    super.onInit();
  }

  Future<void> loadUserInfo() async {
    try {
      isSetLoading = true;
      accountEntity.value = await loadCurrentAccount.loadUserEntity();
      isSetLoading = false;
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> _loadAulasByIdProfessor() async {
    try {
      isSetLoading = true;
      if (accountEntity.value != null) {
        aulaEntity.value = await classroomUsecase.loadAulaByUsuario(accountEntity.value!.id!);
        _sortedByMostRecent();
      }
      isSetLoading = false;
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Future<void> startClass(AulaEntity? aulaEntity) async {
    try {
      isSetLoading = true;
      if (aulaEntity != null) {
        await classroomUsecase.startClass(aulaEntity);
      }
      isSetLoading = false;
    } catch (e) {
      Exception(e);
    }
  }

  void _sortedByMostRecent() {
    final dateNow = DateTime.now();
    if (aulaEntity.value != null) {
      aulaEntity.value?.sort((a, b) {
        final list1 = dateNow.difference(a.dataAula!).inDays.abs();
        final list2 = dateNow.difference(b.dataAula!).inDays.abs();
        return list1.compareTo(list2);
      });
    }
  }
}
