import 'package:flutter/material.dart';

import 'package:qreader_app/src/pages/home_page.dart';
import 'package:qreader_app/src/pages/map_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QReader',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'map' : (BuildContext context) => MapPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}