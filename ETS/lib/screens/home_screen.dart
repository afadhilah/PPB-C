import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/book.dart';
import '../models/author.dart';
import 'book_form_screen.dart';
import 'author_list_screen.dart';
import 'book_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookBox = Hive.box<Book>('books');
    final authorBox = Hive.box<Author>('authors');

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Buku')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Menu")),
            ListTile(
              title: const Text("Penulis"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthorListScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: bookBox.listenable(),
        builder: (context, Box<Book> books, _) {
          if (books.isEmpty) {
            return const Center(child: Text('Belum ada buku'));
          }

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books.getAt(index);
              final author = authorBox.get(book?.authorId);

              return ListTile(
                leading: book!.coverUrl.isNotEmpty
                    ? Image.network(book.coverUrl, width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.book),
                title: Text(book.title),
                subtitle: Text('Penulis: ${author?.name ?? "Tidak diketahui"}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(bookId: book.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookFormScreenEdit(book: Book(id: 0, title: '', description: '', coverUrl: '', authorId: 0)),),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
