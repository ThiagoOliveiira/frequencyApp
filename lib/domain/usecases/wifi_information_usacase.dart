import '../domain.dart';

abstract class WifiInformationUsecase {
  Future<void> saveNetworkInformation(WifiClassConfirmationEntity wifiClassConfirmationEntity);
  Future<WifiClassConfirmationEntity?> getNetworkInformationByIdClass(int idClass);
}
