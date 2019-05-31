import 'company.dart';
import 'tag.dart';

class Offer {
  final String id;
  final String name;
  final DateTime begin;
  final DateTime end;
  final Company company;
  final List<Tag> tags;

  Offer({this.id, this.name, this.begin, this.end, this.company, this.tags});

  factory Offer.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return Offer(
      id: json['id'],
      name: json['name'],
      begin: json['begin'],
      end: json['end'],
      company: Company.fromJson(json['company']),
      tags: (json['tags'] as List<dynamic>)
          ?.map((x) => Tag.fromJson(x))
          ?.toList(),
    );
  }

  bool hasTag(String tagId) {
    return this.tags?.any((x) => x.id == tagId) ?? false;
  }
}
