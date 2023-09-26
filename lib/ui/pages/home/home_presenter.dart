import 'package:get/get.dart';

import '../../ui.dart';

abstract class HomePresenter {
  UserType? get userType;
  RxInt get currentPageIndex;
}
