import '../domain.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity? account);
}
