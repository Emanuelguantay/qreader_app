import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qreader_app/src/bloc/scans_bloc.dart';
import 'package:qreader_app/src/models/scan_model.dart';
import 'package:qreader_app/src/pages/address_page.dart';
import 'package:qreader_app/src/pages/maps_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qreader_app/src/utils/utils.dart' as utils;

void main() => runApp(HomePage());
 
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;
  String _scanBarcode = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed:
              scansBloc.deleteAllScans
            ,
          )
        ],
      ),
        body: _callPage(currentIndex),
        bottomNavigationBar: _createBottomNavigatorBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton(){
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: scanQR,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Future<void> scanQR() async {
    //String barcodeScanRes;
    //"https://github.com/Emanuelguantay"
    //"geo:40.724233047051705,-74.00731459101564"

    //String futureString = '';
    String futureString = 'https://github.com/Emanuelguantay';

    // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    //   '#ff6666', 'cancel', true, ScanMode.QR);
    
    // try {
    //   futureString = await FlutterBarcodeScanner.scanBarcode(
    //       '#ff6666', 'Cancel', true, ScanMode.QR);
    //   print(futureString);
    // } catch (e) {
    //   futureString = 'Failed to get platform version.';
    // }

    //if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
    if (futureString != null){
      final scan = ScanModel(value: futureString);
      scansBloc.addScan(scan);

      final scan2 = ScanModel(value: 'geo:40.724233047051705,-74.00731459101564');
      scansBloc.addScan(scan2);
      //DBProvider.db.newScan(scan);

      if (Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750),(){
          utils.openScan(scan);
        });
      }else{
        utils.openScan(scan);
      }
    }
  }

  _scanQR() async{
    String futureString = '';
    try{
      futureString = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'cancel', true, ScanMode.QR);
    }catch(e){
      futureString = e.toString();
    }



    print("FutureStrig: $futureString");

    if (futureString != null){
      print("Tenemos información");
    }
  }

  _callPage(int page){
    switch(page){
      case 0:
        return MapsPage();
      case 1:
        return AddressPage();
      default:
        return MapsPage();
    }
  }

  _createBottomNavigatorBar(){
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Mapas",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          label: "Direcciones",
        )
      ]
    );
  }
}