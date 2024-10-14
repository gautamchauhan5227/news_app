import 'package:isar/isar.dart';
import 'package:news_app/core/local_model/article_model.dart';

class IsarService<T extends ArticleModel> {
  final IsarCollection<T> collection;

  IsarService(this.collection);

  /// Add a single item if the title doesn't already exist
  Future<bool> addItem(T item) async {
    final isar = collection.isar;

    // Check if an article with the same title already exists
    final existingArticles = await collection.where().findAll();

    bool titleExists =
        existingArticles.any((article) => article.title == item.title);

    if (titleExists) {
      return false; // Title already exists; do not add the item
    }

    // Add the item if the title does not exist
    await isar.writeTxn(() async {
      await collection.put(item);
    });
    return true;
  }

  /// Remove a single item by ID
  Future<void> removeItemById(Id id) async {
    final isar = collection.isar;
    await isar.writeTxn(() async {
      await collection.delete(id);
    });
  }

  /// Find all items
  Future<List<T>> findAll() async {
    return await collection.where().findAll();
  }
}
