import 'package:frequency_app/data/data.dart';
import '../../../domain/domain.dart';

class RemoteAuthentication extends Authentication {
  final PostDatabase postDatabase;
  // final HttpClient httpClient;
  // final String url;

  RemoteAuthentication({required this.postDatabase});

  @override
  Future<AccountEntity?> auth(AuthenticationParams params) async {
    try {
      final httpResponse =
          await postDatabase.post(query: 'SELECT * FROM USUARIO WHERE matricula = @aMatricula and senha = @aSenha', substitutionValues: {"aMatricula": params.matricula, "aSenha": params.senha});

      if (httpResponse == null) DomainError.invalidCredentials;

      final resultJson = httpResponse.map((e) => AccountEntity.toMap(e)).toList();

      return RemoteAccountModel.fromJson(resultJson.first).toEntity();
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
