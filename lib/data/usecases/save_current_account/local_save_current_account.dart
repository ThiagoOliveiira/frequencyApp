import '../../../domain/domain.dart';
import '../../cache/cache.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity? account) async {
    try {
      await saveSecureCacheStorage.save(key: 'id', value: account!.id.toString());
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
