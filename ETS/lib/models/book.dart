import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String coverUrl;

  @HiveField(4)
  int authorId;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.authorId,
  });
}
