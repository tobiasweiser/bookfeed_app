import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'welcome_page.dart';
import 'package:provider/provider.dart';
import '../providers/feed_provider.dart';
import '../models/book.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookFeed'),
        centerTitle: true,
      ),
      body: Consumer<FeedProvider>(
        builder: (context, feed, _) {
          if (feed.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (feed.error != null) {
            return Center(child: Text('Fehler: ${feed.error}'));
          }
          final books = feed.books;
          if (books.isEmpty) {
            return const Center(child: Text('Noch keine Bücher verfügbar'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final Book book = books[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Image.network(book.coverUrl, width: 50, fit: BoxFit.cover),
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // TODO: Implement like logic
                    },
                  ),
                  onTap: () {
                    // TODO: Navigate to detail page
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.read<AuthProvider>().signOut();
          Navigator.pushReplacementNamed(context, '/');
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}