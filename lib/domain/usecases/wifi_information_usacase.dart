import '../domain.dart';

abstract class WifiInformationUsecase {
  Future<void> saveNetworkInformation(WifiClassConfirmationEntity wifiClassConfirmationEntity);
}
