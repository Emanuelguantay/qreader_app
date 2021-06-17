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

  }

}