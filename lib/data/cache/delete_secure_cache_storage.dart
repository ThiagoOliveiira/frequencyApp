/// Interface to handle Delete usecases on SecureStorage module without exposing the SDK to another application layers.
abstract class DeleteSecureCacheStorage {
  /// abstract method implemented on [SecureStorageAdapter] to deleteAll saved keys at the same time
  Future<void> deleteAll();

  /// abstract method implemented on [SecureStorageAdapter] to delete a specific key saved on SecureStorage
  Future<void> deleteByKey(String key);
}
