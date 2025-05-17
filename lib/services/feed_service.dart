import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FeedService {
  final _col = FirebaseFirestore.instance.collection('books');

  Stream<List<Book>> bookStream() {
    return _col
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) =>
        snap.docs.map((doc) => Book.fromFirestore(doc)).toList(),
      );
  }

  Future<List<Book>> fetchBooksOnce() async {
    final snap = await _col.orderBy('createdAt', descending: true).get();
    return snap.docs.map((doc) => Book.fromFirestore(doc)).toList();
  }

  Future<void> addBook(Book book) => _col.add(book.toJson());
}