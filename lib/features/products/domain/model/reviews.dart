import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'reviews.g.dart';

@HiveType(typeId: 0)
class Reviews extends Equatable {
  @HiveField(0)
  final int rating;
  @HiveField(1)
  final String comment;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String reviewerName;
  @HiveField(4)
  final String reviewerEmail;

  const Reviews({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  Reviews copyWith({
    int? rating,
    String? comment,
    String? date,
    String? reviewerName,
    String? reviewerEmail,
  }) {
    return Reviews(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerEmail: reviewerEmail ?? this.reviewerEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(
      rating: map['rating'] as int,
      comment: map['comment'] as String,
      date: map['date'] as String,
      reviewerName: map['reviewerName'] as String,
      reviewerEmail: map['reviewerEmail'] as String,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    rating,
    comment,
    date,
    reviewerName,
    reviewerEmail,
  ];
}
