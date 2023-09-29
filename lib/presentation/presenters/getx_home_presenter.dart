import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxHomePresenter({required this.loadCurrentAccount});

  @override
  Rx<UserType?> userType = Rx(null);

  @override
  RxInt currentPageIndex = 0.obs;

  @override
  void onInit() async {
    await loadUserInfo();
    super.onInit();
  }

  Future<void> loadUserInfo() async {
    var userEntity = await loadCurrentAccount.loadUserEntity();

    if (userEntity != null) userType.value = userEntity.tipo?.contains('aluno') == true ? UserType.aluno : UserType.professor;
  }
}
