import 'package:app_dagens/store/actions.dart';
import 'package:app_dagens/models/geo_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppStore {
  List<GeoLocation> geoLocations = [];
  CameraPosition cameraPosition;
  List<String> tags = [];
}

AppStore geoLocationReducer(AppStore state, dynamic action) {
  // Set markers
  if (action is AddGeoLocationsAction) {
    var added = state.geoLocations.map((x) => x.id);

    for (var item in action.payload) {
      if (added.contains(item.id)) {
        continue;
      }

      state.geoLocations.add(item);
    }
  }

  // Set last camera position
  if (action is SetLastCameraPosition) {
    state.cameraPosition = action.payload;
  }

  // Set selected tags
  if (action is ToggleTag) {
    if (state.tags.contains(action.tagId)) {
      state.tags.remove(action.tagId);
    } else {
      state.tags.add(action.tagId);
    }
  }

  return state;
}
