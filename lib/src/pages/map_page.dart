import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qreader_app/src/models/scan_model.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Coordenadas QR'),
          actions: [
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {},
            )
          ],
        ),
        body: _createFlutterMap(scan));
  }

  _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 13.0,
      ),
      layers: [
        _createMap(),
        _createMarker(scan)
      ],
    );
  }

  _createMap(){
    return TileLayerOptions(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']
      // urlTemplate: 'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      // additionalOptions: {
      //   'accessToken': 'pk.eyJ1IjoiZW1hbnVlbC1ndWFudGF5IiwiYSI6ImNrcWQ1N2VzdjEyZnEydW11OTF4b25rbWoifQ.OX07ysGs1YTMi_cO-CAO3A',
      //   'id': 'mapbox.streets'
      // }
    );
  }

  _createMarker(ScanModel scan){
    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: (context) =>
            Container(
              child: Icon(Icons.location_on,
              size: 60.0,
              color: Theme.of(context).primaryColor),
            )
        )
      ]
    );
  }
}