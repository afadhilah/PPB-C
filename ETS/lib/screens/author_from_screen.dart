import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/author.dart';

class AuthorFormScreen extends StatefulWidget {
  const AuthorFormScreen({super.key});

  @override
  State<AuthorFormScreen> createState() => _AuthorFormScreenState();
}

class _AuthorFormScreenState extends State<AuthorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Penulis')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (val) => val!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final authorBox = Hive.box<Author>('authors');
                    final newAuthor = Author(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: _nameController.text,
                      bio: _bioController.text,
                    );
                    await authorBox.put(newAuthor.id, newAuthor);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
