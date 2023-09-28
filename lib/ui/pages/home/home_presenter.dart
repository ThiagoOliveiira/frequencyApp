import 'package:get/get.dart';

import '../../ui.dart';

abstract class HomePresenter {
  Rx<UserType?> get userType;
  RxInt get currentPageIndex;
}
