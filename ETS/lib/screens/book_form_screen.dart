import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/book.dart';
import '../models/author.dart';

class BookFormScreenEdit extends StatefulWidget {
  final Book book;
  const BookFormScreenEdit({super.key, required this.book});

  @override
  State<BookFormScreenEdit> createState() => _BookFormScreenEditState();
}

class _BookFormScreenEditState extends State<BookFormScreenEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _coverUrlController;
  int? _selectedAuthorId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _descController = TextEditingController(text: widget.book.description);
    _coverUrlController = TextEditingController(text: widget.book.coverUrl);
    _selectedAuthorId = widget.book.authorId;
  }

  @override
  Widget build(BuildContext context) {
    final authorBox = Hive.box<Author>('authors');
    final authors = authorBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Buku')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Buku'),
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: _coverUrlController,
                decoration: const InputDecoration(labelText: 'URL Cover'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedAuthorId,
                items: authors.map((author) {
                  return DropdownMenuItem(
                    value: author.id,
                    child: Text(author.name),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedAuthorId = val),
                decoration: const InputDecoration(labelText: 'Penulis'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final updatedBook = Book(
                    id: widget.book.id,
                    title: _titleController.text,
                    description: _descController.text,
                    coverUrl: _coverUrlController.text,
                    authorId: _selectedAuthorId!,
                  );
                  await Hive.box<Book>('books').put(widget.book.id, updatedBook);
                  Navigator.pop(context);
                },
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
