import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_dagens/models/geo_location.dart';
import 'package:app_dagens/queries.dart';

class PageBloc {
  final GraphQLClient client;

  PageBloc(this.client);

  Map<String, double> _getVariabels(LatLngBounds bounds) {
    return {
      'fromLat': bounds.southwest.latitude,
      'toLat': bounds.northeast.latitude,
      'fromLong': bounds.southwest.longitude,
      'toLong': bounds.northeast.longitude,
    };
  }

  Future<List<GeoLocation>> search(LatLngBounds bounds) async {
    var result = await this.client.query(QueryOptions(
        document: filterGeoLocations, variables: _getVariabels(bounds)));

    if (result.errors != null) {
      return null;
    }

    var json = result.data['allGeoLocations'] as List<dynamic>;
    if (json == null) {
      return null;
    }

    return json.map((x) => GeoLocation.fromJson(x)).toList();
  }
}
