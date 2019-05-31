import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:app_dagens/models/geo_location.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocation/geolocation.dart';
import './components/tags_filter_view.dart';
import './page_block.dart';
import 'package:app_dagens/pages/map/components/result_view.dart';
import 'package:app_dagens/store/reducer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app_dagens/queries.dart' as queries;

class MapPage extends StatefulWidget {
  MapPage({Key key, this.store}) : super(key: key);

  final Store<AppStore> store;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _googleMapController;
  PanelController _panelController = PanelController();
  PageBloc _bloc;

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen = 575.0;
  double _panelHeightClosed = 95.0;
  var _hits = List<GeoLocation>();
  final _cameraPosition = PublishSubject<CameraPosition>();

  @override
  void initState() {
    super.initState();
    this._fabHeight = _initFabHeight;

    _cameraPosition
        .debounce(Duration(milliseconds: 500))
        .listen((CameraPosition _) async {
      var bounds = await this._googleMapController.getVisibleRegion();
      var result = await this._bloc.search(bounds);

      if (result == null) {
        return;
      }

      var newIds = result.map((x) => x.id);
      var oldIds = _hits.map((x) => x.id);

      if (newIds.length != oldIds.length) {
        setHits(result);
      }

      if (newIds.any((x) => !oldIds.contains(x))) {
        setHits(result);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._bloc = PageBloc(GraphQLProvider.of(this.context).value);
  }

  void setHits(List<GeoLocation> hits) {
    setState(() {
      _hits = hits;
    });
  }

  Future<void> _showUsersLocation() async {
    await Geolocation.requestLocationPermission();
    var location = await Geolocation.lastKnownLocation();

    if (!location.isSuccessful) {
      return;
    }

    var cameraUpdate = CameraUpdate.newLatLng(
      LatLng(location.location.latitude, location.location.longitude),
    );

    this._googleMapController.animateCamera(cameraUpdate);
  }

  Marker _markerFrom(GeoLocation location) {
    return location.toMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppStore, List<String>>(
        converter: (store) => store.state.tags,
        builder: (BuildContext bc, List<String> tags) {
          var hits = _hits.where((x) => isVisible(x, tags)).toList();
          return Stack(
            children: <Widget>[
              _slidingPanel(hits),
              _floatingUserLocationButton(),
            ],
          );
        },
      ),
    );
  }

  static bool isVisible(GeoLocation hit, List<String> tags) {
    if (tags == null || tags.isEmpty) {
      return true;
    }

    return hit.company.offers.any((o) => tags.any((t) => o.hasTag(t)));
  }

  void _onPanelSlide(double pos) {
    setState(() {
      _fabHeight =
          pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
    });
  }

  Widget _floatingUserLocationButton() {
    return Positioned(
      right: 20.0,
      bottom: _fabHeight,
      child: FloatingActionButton(
        child: Icon(
          Icons.gps_fixed,
          color: Colors.black,
        ),
        onPressed: this._showUsersLocation,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _slidingPanel(List<GeoLocation> state) {
    return SlidingUpPanel(
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      maxHeight: _panelHeightOpen,
      minHeight: _panelHeightClosed,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      body: _body(state),
      panel: _panel(state),
      onPanelSlide: _onPanelSlide,
      controller: _panelController,
    );
  }

  Widget _body(List<GeoLocation> state) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          59,
          18,
        ),
        zoom: 15.0,
      ),
      myLocationEnabled: true,
      markers: state.map(this._markerFrom).toSet(),
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          this._googleMapController = controller;
          this._showUsersLocation();
        });
      },
      onCameraMove: this._cameraPosition.add,
    );
  }

  Widget _panel(List<GeoLocation> state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 12.0,
        ),
        GestureDetector(
          onTap: this._togglePanel,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
        ),
        TagsFilterView(),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            "Träffar (${state.where((x) => x.company.offers.isNotEmpty).length})",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ResultListView(
              geoLocations:
                  state.where((x) => x.company.offers.isNotEmpty).toList()),
        )
      ],
    );
  }

  void _togglePanel() {
    _panelController.isPanelOpen()
        ? _panelController.close()
        : _panelController.open();
  }
}
