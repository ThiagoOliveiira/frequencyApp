import 'package:frequency_app/data/usecases/aula/remote_wifi_information.dart';
import 'package:frequency_app/domain/domain.dart';

import '../factories.dart';

WifiInformationUsecase makeRemoteWifiInformation() => RemoteWifiInformation(postDatabase: makeConnectionDatabaseAdapter(), getDatabase: makeConnectionDatabaseAdapter());
