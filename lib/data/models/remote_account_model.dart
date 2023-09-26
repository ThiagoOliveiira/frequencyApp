import '../../domain/domain.dart';
import '../http/http.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel({required this.accessToken});

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('access_token')) {
      throw HttpError.invalidData;
    }

    return RemoteAccountModel(accessToken: json['access_token']);
  }

  AccountEntity toEntity() => AccountEntity(token: accessToken);
}
