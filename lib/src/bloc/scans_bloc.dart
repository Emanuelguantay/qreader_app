import 'dart:async';

import 'package:qreader_app/src/bloc/validator.dart';
import 'package:qreader_app/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Obtener Scans de la Base de Datos
    getScanAll();
  }

  //Streasm
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream     => _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validateHttp);


  dispose(){
    _scansController?.close();
  }

  getScanAll() async{
    _scansController.sink.add(await DBProvider.db.getScanAll());
  }

  addScan(ScanModel scan) async{
    await DBProvider.db.newScan(scan);
    getScanAll();
  }

  deleteScan(int id) async{
    await DBProvider.db.deleteScan(id);
    getScanAll();
  }

  deleteAllScans() async{
    await DBProvider.db.deleteAll();
    getScanAll();
  }
}