import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/author.dart';
import 'models/book.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AuthorAdapter());
  Hive.registerAdapter(BookAdapter());

  await Hive.openBox<Author>('authors');
  await Hive.openBox<Book>('books');

  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
