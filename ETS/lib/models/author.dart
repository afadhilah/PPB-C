import 'package:hive/hive.dart';

part 'author.g.dart';

@HiveType(typeId: 1)
class Author extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String bio;

  Author({
    required this.id,
    required this.name,
    required this.bio,
  });
}
