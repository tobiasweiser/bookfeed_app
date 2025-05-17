import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../services/feed_service.dart';

class FeedProvider extends ChangeNotifier {
  final FeedService _service = FeedService();

  List<Book> _books = [];
  bool _isLoading = true;
  String? _error;

  FeedProvider() {
    _init();
  }

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _init() {
    _service.bookStream().listen((data) {
      _books = data;
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    try {
      _books = await _service.fetchBooksOnce();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}