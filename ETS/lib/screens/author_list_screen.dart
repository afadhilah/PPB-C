import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/author.dart';
import '../models/book.dart';
import 'book_detail_screen.dart';
import 'book_form_screen.dart';

class AuthorListScreen extends StatefulWidget {
  const AuthorListScreen({super.key});

  @override
  State<AuthorListScreen> createState() => _AuthorListScreenState();
}

class _AuthorListScreenState extends State<AuthorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedAuthorId;

  @override
  void dispose() {
    // Membersihkan controller untuk menghindari kebocoran memori
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookBox = Hive.box<Book>('books');
    final authorBox = Hive.box<Author>('authors');
    final authors = authorBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Buku')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Cari Judul',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<int>(
              value: _selectedAuthorId,
              items: [
                const DropdownMenuItem(value: null, child: Text('Semua Penulis')),
                ...authors.map((a) => DropdownMenuItem(
                      value: a.id,
                      child: Text(a.name),
                    )),
              ],
              onChanged: (val) => setState(() => _selectedAuthorId = val),
              decoration: const InputDecoration(labelText: 'Filter Penulis'),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: bookBox.listenable(),
              builder: (context, Box<Book> books, _) {
                final search = _searchController.text.toLowerCase();
                final filtered = books.values.where((book) {
                  final matchesSearch = book.title.toLowerCase().contains(search);
                  final matchesAuthor = _selectedAuthorId == null || book.authorId == _selectedAuthorId;
                  return matchesSearch && matchesAuthor;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('Tidak ada buku ditemukan.'));
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final book = filtered[index];
                    final author = authorBox.get(book.authorId);

                    return ListTile(
                      leading: book.coverUrl.isNotEmpty
                          ? Image.network(book.coverUrl, width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.book),
                      title: Text(book.title),
                      subtitle: Text(author?.name ?? 'Tidak diketahui'),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookFormScreenEdit(book: Book(id: 0, title: '', description: '', coverUrl: '', authorId: 0))),
          );
        },
      ),
    );
  }
}