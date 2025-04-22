import 'package:flutter/material.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Books',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Tambahkan logika pencarian di sini
                print('Search query: $value');
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Ganti dengan jumlah buku yang sebenarnya
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Book $index'), // Ganti dengan data buku
                  subtitle: Text('Author ID: $_selectedAuthorId'),
                  onTap: () {
                    setState(() {
                      _selectedAuthorId = index; // Contoh logika pemilihan
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}