import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SplashPresenter {
  RxBool get isLoading;

  Rx<List<Color?>> get colors;
  Rx<int> get currentIndex;
}
