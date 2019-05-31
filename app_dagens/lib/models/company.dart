import 'geo_location.dart';
import 'user.dart';
import 'tag.dart';
import 'offer.dart';

class Company {
  final String id;
  final String name;
  final String image;
  final String text;
  final List<GeoLocation> geoLocations;
  final List<User> users;
  final List<Tag> tags;
  final List<Offer> offers;

  Company(
      {this.id,
      this.name,
      this.image,
      this.text,
      this.geoLocations,
      this.users,
      this.offers,
      this.tags});

  factory Company.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return Company(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      text: json['text'],
      geoLocations: (json['geoLocations'] as List<dynamic>)
          ?.map((x) => GeoLocation.fromJson(x))
          ?.toList(),
      users: (json['users'] as List<dynamic>)
          ?.map((x) => User.fromJson(x))
          ?.toList(),
      tags: (json['tags'] as List<dynamic>)
          ?.map((x) => Tag.fromJson(x))
          ?.toList(),
      offers: (json['offers'] as List<dynamic>)
          ?.map((x) => Offer.fromJson(x))
          ?.toList(),
    );
  }
}

enum CompanyVisibility { all, admin, owner }
