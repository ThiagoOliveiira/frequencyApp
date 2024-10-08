import '../../../data/data.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

SaveCurrentAccount makeLocalSaveCurrentAccount() => LocalSaveCurrentAccount(saveSecureCacheStorage: makeSecureStorageAdapter());
