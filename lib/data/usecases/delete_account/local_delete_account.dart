import 'package:frequency_app/data/cache/cache.dart';
import 'package:frequency_app/domain/domain.dart';

class LocalDeleteAccount extends DeleteAccount {
  final DeleteSecureCacheStorage deleteSecureCacheStorage;

  LocalDeleteAccount({required this.deleteSecureCacheStorage});

  @override
  Future<void> deleteLocalAccount() async {
    try {
      await deleteSecureCacheStorage.deleteByKey('account');
    } catch (e) {
      throw Exception(e);
    }
  }
}
