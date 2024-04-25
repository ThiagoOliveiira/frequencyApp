import 'package:frequency_app/main/factories/factories.dart';

import '../../../../presentation/presentation.dart';
import '../../../../ui/ui.dart';

ClassroomPresenter makeGetxClassroomPresenter() => GetxClassroomPresenter(
      classroomUsecase: makeRemoteLoadAula(),
      loadCurrentAccount: makeLocalLoadCurrentAccount(),
      wifiInformationUsecase: makeRemoteWifiInformation(),
      loadStudentFrequency: makeRemoteLoadStudentFrequency(),
    );
