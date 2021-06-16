import 'package:flutter/material.dart';
 
void main() => runApp(HomePage());
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            child: Text('Hello HomePage'),
          ),
        ),
    );
  }
}