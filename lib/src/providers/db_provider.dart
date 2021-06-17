import 'dart:io';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:qreader_app/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  //Patron Singleton
  //Creando una propiedad privada, es mi instancia de la BD
  static Database _dataBase;

  //Instancia de la clase y es un constructor privado 
  static final DBProvider db = DBProvider._();

  //Es para que la propiedad no se reinicialice
  DBProvider._();

  Future<Database> get database async{
    if (_dataBase != null) return _dataBase;

    _dataBase = await initDB();

    return _dataBase;
  }

  initDB() async{
    //crear una instancia de la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute(
          'CREATE TABLE Scans ('
            'id INTEGER PRIMARY KEY,'
            'type TEXT,'
            'value TEXT'
          ')'
        );
      }
    );
  }

  //Create Registes
  newScanRaw(ScanModel newScan) async{
    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans ( id, type, value) "
      "VALUES ( ${newScan.id}, '${newScan.type}', '${newScan.value}' )"
    );

    return res;
  }

  newScan(ScanModel newScan) async{
    final db = await database;
    
    final res = db.insert('Scans', newScan.toJson());
    return res;
  }

}