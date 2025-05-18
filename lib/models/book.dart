import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

/// Hilfsfunktionen für Timestamp <> DateTime Mapping
DateTime _timestampToDate(Timestamp timestamp) => timestamp.toDate();
Timestamp _dateTimeToTimestamp(DateTime date) => Timestamp.fromDate(date);

@JsonSerializable()
class Book {
  @JsonKey(ignore: true)
  final String? id;

  final String title;
  final String? author;
  final String? coverUrl;
  final String? summary;
  final String? affiliateUrl;

  @JsonKey(defaultValue: [])
  final List<String> tags;

  @JsonKey(fromJson: _timestampToDate, toJson: _dateTimeToTimestamp)
  final DateTime createdAt;

  Book({
    this.id,
    required this.title,
    this.author,
    this.coverUrl,
    this.summary,
    this.affiliateUrl,
    this.tags = const [],
    required this.createdAt,
  });

  /// Baut aus einem Firestore-Dokument ein Book-Objekt
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