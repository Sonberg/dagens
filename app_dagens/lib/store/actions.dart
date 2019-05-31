import 'package:app_dagens/models/geo_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddGeoLocationsAction {
  final List<GeoLocation> payload;
  AddGeoLocationsAction({this.payload});
}

class SetLastCameraPosition {
  final CameraPosition payload;
  SetLastCameraPosition({this.payload});
}

class ToggleTag {
  final String tagId;
  ToggleTag({this.tagId});
}
