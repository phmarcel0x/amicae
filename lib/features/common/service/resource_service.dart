abstract class IResourceService<T> {
  Future<List<T>> findAll();

  Future<T> findById(String id);

  Future<T> update(T entity);

  Future<void> delete(String id);
}
