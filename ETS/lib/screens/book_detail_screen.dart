import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/book.dart';
import '../models/author.dart';
import 'book_form_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final int bookId;

  const BookDetailScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final bookBox = Hive.box<Book>('books');
    final authorBox = Hive.box<Author>('authors');

    final book = bookBox.get(bookId);
    final author = authorBox.get(book?.authorId);

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Buku')),
        body: const Center(child: Text('Buku tidak ditemukan')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookFormScreenEdit(book: book),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Hapus Buku?'),
                  content: const Text('Yakin ingin menghapus buku ini?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Hapus'),
                    ),
                  ],
                ),
              );

              if (confirm ?? false) {
                await bookBox.delete(bookId);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (book.coverUrl.isNotEmpty)
              Image.network(book.coverUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Penulis: ${author?.name ?? 'Tidak diketahui'}'),
            const Divider(height: 24),
            Text(book.description),
          ],
        ),
      ),
    );
  }
}
