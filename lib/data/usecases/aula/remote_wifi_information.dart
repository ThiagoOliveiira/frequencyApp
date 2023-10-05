import '../../../domain/domain.dart';
import '../../data.dart';

class RemoteWifiInformation implements WifiInformationUsecase {
  final GetDatabase getDatabase;
  final PostDatabase postDatabase;

  RemoteWifiInformation({required this.postDatabase, required this.getDatabase});

  @override
  Future<void> saveNetworkInformation(WifiClassConfirmationEntity wifiEntity) async {
    try {
      String select = "INSERT INTO public.wifi_aula_confirmacao (wifi1, wifi2, wifi3, id_aula) VALUES(@oSsid1, @oSsid2, @oSsid3, @oAulaId)";

      print(wifiEntity);

      final httpResponse =
          await postDatabase.post(query: select, substitutionValues: {'oSsid1': wifiEntity.ssid1, 'oSsid2': wifiEntity.ssid2, 'oSsid3': wifiEntity.ssid3, 'oAulaId': wifiEntity.aulaId});
    } catch (error) {
      print(error);
    }
  }
}
