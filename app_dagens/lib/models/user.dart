import 'company.dart';

class User {
  final String id;
  final String name;
  final UserType type;
  final List<Company> companies;

  User({this.id, this.name, this.type, this.companies});

  factory User.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return User(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      companies:
          (json['companies'] as List<dynamic>)?.map((x) => Company.fromJson(x)),
    );
  }
}

enum UserType { user, admin }
