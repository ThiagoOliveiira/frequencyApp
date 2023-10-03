import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../cache/cache.dart';

DeleteAccount makeLocalDeleteAccount() => LocalDeleteAccount(deleteSecureCacheStorage: makeSecureStorageAdapter());
