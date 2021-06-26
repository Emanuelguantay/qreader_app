


import 'dart:async';

import 'package:qreader_app/src/models/scan_model.dart';

class Validators{
  //entra una informaicon y sale otra
  final validateGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){
      final geoScans = scans.where((element) => element.type == 'geo').toList();
      sink.add(geoScans);
    }
  );

  final validateHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink){
      final httpScans = scans.where((element) => element.type == 'http').toList();
      sink.add(httpScans);
    }
  );
}