import 'package:flutter/material.dart';
import 'package:frequency_app/presentation/presentation.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';

class GetxHomePresenter extends GetxController with LoadingManager implements HomePresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final DeleteAccount deleteAccount;

  GetxHomePresenter({required this.loadCurrentAccount, required this.deleteAccount});

  @override
  Rx<UserType?> userType = Rx(null);

  @override
  RxInt currentPageIndex = 0.obs;

  @override
  Rx<AccountEntity?> accountEntity = Rx(null);

  @override
  void onInit() async {
    await loadUserInfo();
    super.onInit();
  }

  Future<void> loadUserInfo() async {
    accountEntity.value = await loadCurrentAccount.loadUserEntity();

    if (accountEntity.value != null) userType.value = accountEntity.value?.tipo?.contains('aluno') == true ? UserType.aluno : UserType.professor;
    await requestLocationPermition();
  }

  @override
  Future<void> logout() async {
    try {
      isSetLoading = true;
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: '',
        radius: 15,
        barrierDismissible: false,
        content: Column(
          children: const [
            SizedBox(height: 30, width: 30, child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.bluegreen600)),
            SizedBox(height: 20),
            Text('Saindo...', style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.bluegreen600))
          ],
        ),
      );
      deleteAccount.deleteLocalAccount();

      await Future.delayed(const Duration(seconds: 2));

      Get.back();

      Get.offAllNamed('/login');

      isSetLoading = false;
    } catch (e) {
      Exception();
    }
  }

  Future<void> requestLocationPermition() async {
    try {
      Location location = Location();

      bool _serviceEnabled;

      _serviceEnabled = await location.serviceEnabled();

      print(_serviceEnabled);
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
    } catch (e) {}
  }
}
