import 'package:equatable/equatable.dart';

class WifiClassConfirmationEntity extends Equatable {
  final int? id;
  final String? ssid1;
  final String? ssid2;
  final String? ssid3;
  final int? aulaId;

  const WifiClassConfirmationEntity({
    required this.id,
    required this.ssid1,
    required this.ssid2,
    required this.ssid3,
    required this.aulaId,
  });

  static Map<String, dynamic> toMapDynamic(List<dynamic>? aulaEntity) => {
        "id": aulaEntity?.first,
        "ssid1": aulaEntity?[1],
        "ssid2": aulaEntity?[2],
        "ssid3": aulaEntity?[3],
        "aulaId": aulaEntity?[4],
      };

  static Map<String, dynamic> toMap(WifiClassConfirmationEntity aulaEntity) => {
        "id": aulaEntity.id,
        "ssid1": aulaEntity.ssid1,
        "ssid2": aulaEntity.ssid2,
        "ssid3": aulaEntity.ssid3,
        "aulaId": aulaEntity.aulaId,
      };

  @override
  List get props => [id, ssid1, ssid2, ssid3, aulaId];
}
