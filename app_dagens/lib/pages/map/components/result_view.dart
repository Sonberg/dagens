import 'package:flutter/material.dart';
import 'package:app_dagens/models/geo_location.dart';
import 'package:app_dagens/models/offer.dart';

class ResultListView extends StatelessWidget {
  final List<GeoLocation> geoLocations;

  ResultListView({this.geoLocations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: geoLocations.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var location = this.geoLocations[index];
        return ResultView(
          geoLocation: location,
          number: index + 1,
        );
      },
    );
  }
}

class ResultView extends StatelessWidget {
  final GeoLocation geoLocation;
  final int number;

  ResultView({this.geoLocation, this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${this.number}. ${this.geoLocation.company.name}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: this.geoLocation.company.offers.length,
              padding: EdgeInsets.only(top: 12, bottom: 0, right: 0, left: 0),
              itemBuilder: (BuildContext bc, int index) {
                return OfferView(offer: this.geoLocation.company.offers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OfferView extends StatelessWidget {
  final Offer offer;

  OfferView({this.offer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          width: 160,
          height: 80,
          margin: EdgeInsets.only(right: 12),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          this.offer.name,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
/*

ListView.builder(
            shrinkWrap: true,
            itemCount: this.geoLocation.company.offers.length,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 12, bottom: 0, right: 0, left: 0),
            itemBuilder: (BuildContext bc, int index) {
              return OfferView(offer: this.geoLocation.company.offers[index]);
            },
          ),

Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            height: 80,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            this.offer.name,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),

 */

class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      alignment: Alignment.center,
    );
  }
}
