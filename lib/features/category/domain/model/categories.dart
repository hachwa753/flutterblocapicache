import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'categories.g.dart';

@HiveType(typeId: 2)
class Categories extends Equatable {
  @HiveField(0)
  final String slug;
  @HiveField(1)
  final String name;

  const Categories({required this.slug, required this.name});

  @override
  List<Object?> get props => [slug, name];

  Categories copyWith({String? slug, String? name}) {
    return Categories(slug: slug ?? this.slug, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'slug': slug, 'name': name};
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(slug: map['slug'] as String, name: map['name'] as String);
  }
}
