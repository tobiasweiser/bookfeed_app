import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  @JsonKey(ignore: true)
  final String? id;         // Doc-ID: ignorieren beim JSON

  final String title;       // Titel des Buchs
  final String author;      // Autor
  final String coverUrl;    // Link zum Cover-Bild
  final String summary;     // Kurze Zusammenfassung
  final String affiliateUrl;// Link zum E-Book / Kauf
  final List<String>? tags; // Themen / Genres
  final DateTime createdAt; // Erstellungszeitpunkt

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.summary,
    required this.affiliateUrl,
    this.tags,
    required this.createdAt,
  });

  /// Baut aus Firestore-Snapshot ein Book-Objekt
  factory Book.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final book = Book.fromJson(data);
    return book.copyWith(id: doc.id);
  }

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);

  Book copyWith({String? id}) => Book(
    id: id ?? this.id,
    title: title,
    author: author,
    coverUrl: coverUrl,
    summary: summary,
    affiliateUrl: affiliateUrl,
    tags: tags,
    createdAt: createdAt,
  );
}