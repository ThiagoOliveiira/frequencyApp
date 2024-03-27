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

      await postDatabase.post(query: select, substitutionValues: {'oSsid1': wifiEntity.ssid1, 'oSsid2': wifiEntity.ssid2, 'oSsid3': wifiEntity.ssid3, 'oAulaId': wifiEntity.aulaId});
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<WifiClassConfirmationEntity?> getNetworkInformationByIdClass(int idClass) async {
    try {
      String select = "SELECT * FROM wifi_aula_confirmacao w WHERE w.id_aula = @idClass";

      final httpResponse = await getDatabase.get(query: select, substitutionValues: {'idClass': idClass});

      if (httpResponse == null) {
        return null;
      }

      final resultJson = httpResponse.map((e) => WifiClassConfirmationEntity.toMapDynamic(e)).toList();
      if (resultJson != null) {
        return WifiClassConfirmationModel.fromJson(resultJson.first).toEntity();
      }

      return null;
    } catch (error) {
      throw Exception(error);
    }
  }
}
