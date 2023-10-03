import 'package:get/get.dart';
import '../../domain/domain.dart';
import '../../ui/ui.dart';
import '../mixins/mixins.dart';

class GetxSplashPagePresenter extends GetxController with LoadingManager implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPagePresenter({required this.loadCurrentAccount});

  @override
  void onInit() async {
    await _loadUserInfo();

    super.onInit();
  }

  Future<void> _loadUserInfo() async {
    try {
      isSetLoading = true;
      var userEntity = await loadCurrentAccount.loadUserEntity();
      await Future.delayed(const Duration(seconds: 2));
      isSetLoading = false;
      Get.offAllNamed(userEntity != null ? '/home' : '/login');
    } catch (e) {
      Exception(e);
    }
  }
}
