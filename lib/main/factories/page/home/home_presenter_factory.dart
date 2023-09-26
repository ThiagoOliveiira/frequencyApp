import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';
import '../../factories.dart';

HomePresenter makeGetxHomePresenter() => GetxHomePresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());
