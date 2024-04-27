import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';
import '../mixins/mixins.dart';

class GetxSplashPagePresenter extends GetxController with LoadingManager implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  GetxSplashPagePresenter({required this.loadCurrentAccount});

  @override
  Rx<List<Color?>> colors = Rx([Colors.purple, Colors.blue, AppColor.bluegreen600, AppColor.bluegreen, Colors.purple, Colors.blue, AppColor.bluegreen600]);

  @override
  Rx<int> currentIndex = 0.obs;

  @override
  void onInit() async {
    await startColorSequence();
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

  Future<void> startColorSequence() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Timer.periodic(const Duration(milliseconds: 200), (timer) {
        if (colors.value[currentIndex.value] != null) {
          currentIndex.value = (currentIndex.value + 1) % colors.value.length;
        }
      });
    });
    await _loadUserInfo();
  }
}
