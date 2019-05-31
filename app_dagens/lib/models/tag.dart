import 'company.dart';
import 'offer.dart';

class Tag {
  final String id;
  final String value;
  final Company company;
  final List<Offer> offers;

  Tag({this.id, this.value, this.company, this.offers});

  factory Tag.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return Tag(
      id: json['id'],
      value: json['value'],
      company: Company.fromJson(json['company']),
      offers: (json['offers'] as List<dynamic>)
          ?.map((x) => Offer.fromJson(x))
          ?.toList(),
    );
  }
}
