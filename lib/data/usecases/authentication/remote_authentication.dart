import 'package:frequency_app/data/data.dart';
import '../../../domain/domain.dart';

class RemoteAuthentication extends Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  @override
  Future<AccountEntity?> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);

      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final int matricula;
  final String senha;

  RemoteAuthenticationParams({required this.matricula, required this.senha});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) => RemoteAuthenticationParams(matricula: params.matricula, senha: params.senha);

  Map toJson() => {'matricula': matricula, 'senha': senha};
}
