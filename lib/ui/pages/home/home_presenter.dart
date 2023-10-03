import 'package:get/get.dart';

import '../../../domain/domain.dart';
import '../../ui.dart';

abstract class HomePresenter {
  Rx<UserType?> get userType;
  Rx<AccountEntity?> get accountEntity;

  RxInt get currentPageIndex;
  RxBool get isLoading;

  Future<void> logout();
}
