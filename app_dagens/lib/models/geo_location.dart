import 'company.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocation {
  String id;
  double latitude;
  double longitude;
  Company company;

  GeoLocation({this.id, this.latitude, this.longitude, this.company});

  // Convert to marker
  Marker toMarker() {
    return Marker(
        markerId: MarkerId(this.id),
        position: LatLng(this.latitude, this.longitude),
        infoWindow: this.company.offers.isNotEmpty
            ? InfoWindow(title: this.company.offers.first.name)
            : null);
  }

  // Init from JSON
  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return GeoLocation(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      company: Company.fromJson(json['company']),
    );
  }
}
