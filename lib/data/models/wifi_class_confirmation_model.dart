import '../../domain/domain.dart';

class WifiClassConfirmationModel {
  final int? id;
  final String? ssid1;
  final String? ssid2;
  final String? ssid3;
  final int? aulaId;

  const WifiClassConfirmationModel({
    required this.id,
    required this.ssid1,
    required this.ssid2,
    required this.ssid3,
    required this.aulaId,
  });

  static Map<String, dynamic> toMapDynamic(List<dynamic>? wifi) => {
        "id": wifi?.first,
        "ssid1": wifi?[1],
        "ssid2": wifi?[2],
        "ssid3": wifi?[3],
        "aulaId": wifi?[4],
      };

  factory WifiClassConfirmationModel.fromJson(dynamic json) {
    return WifiClassConfirmationModel(
      id: json['id'],
      ssid1: json['ssid1'],
      ssid2: json['ssid2'],
      ssid3: json['ssid3'],
      aulaId: json['aulaId'],
    );
  }

  WifiClassConfirmationEntity toEntity() => WifiClassConfirmationEntity(
        id: id,
        aulaId: aulaId,
        ssid1: ssid1,
        ssid2: ssid2,
        ssid3: ssid3,
      );
}
