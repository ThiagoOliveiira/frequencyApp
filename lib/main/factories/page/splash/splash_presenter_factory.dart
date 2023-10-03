import 'package:frequency_app/main/factories/factories.dart';

import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';

SplashPresenter makeSplashPresenter() => GetxSplashPagePresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());
