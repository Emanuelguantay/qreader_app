// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

// import 'dart:convert';

// ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

// String scanModelToJson(ScanModel data) => json.encode(data.toJson());
import 'package:latlong/latlong.dart';

class ScanModel {
    ScanModel({
        this.id,
        this.type,
        this.value,
    }){
      if(this.value.contains("http")){
        this.type = 'http';
      }else{
        this.type = 'geo';
      }
    }

    int id;
    String type;
    String value;

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
    };

  LatLng getLatLng(){
    final latLng = value.substring(4).split(",");
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat,lng);
  }
}