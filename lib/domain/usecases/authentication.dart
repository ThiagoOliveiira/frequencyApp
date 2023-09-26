import 'package:equatable/equatable.dart';

import '../domain.dart';

abstract class Authentication {
  Future<AccountEntity?> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final int matricula;
  final String senha;

  @override
  List get props => [matricula, senha];

  const AuthenticationParams({required this.matricula, required this.senha});
}
