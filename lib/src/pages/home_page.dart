import 'package:flutter/material.dart';
import 'package:qreader_app/src/pages/address_page.dart';
import 'package:qreader_app/src/pages/maps_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
 
void main() => runApp(HomePage());
 
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){},
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
      onPressed: _scanQR,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  _scanQR() async{
    String futureString = '';
    try{
      futureString = await new QRCodeReader().scan();
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