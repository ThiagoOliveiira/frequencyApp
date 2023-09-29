import 'package:frequency_app/data/data.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity?> loadUserEntity() async {
    try {
      final serializable = await fetchSecureCacheStorage.fetch('id');
      if (serializable == null || serializable.isEmpty) return null;
      return RemoteAccountModel.deserialize(serializable).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
