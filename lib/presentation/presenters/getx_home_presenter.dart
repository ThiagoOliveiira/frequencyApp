import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxHomePresenter({required this.loadCurrentAccount});

  @override
  UserType? userType;

  @override
  RxInt currentPageIndex = 0.obs;

  @override
  void onInit() async {
    await loadUserInfo();
    super.onInit();
  }

  Future<void> loadUserInfo() async {
    var info = await loadCurrentAccount.load();

    var decodeInfo = JwtDecoder.decode(info.token);
    if (decodeInfo.isNotEmpty) userType = decodeInfo.values.contains('aluno') ? UserType.aluno : UserType.professor;
  }
}
