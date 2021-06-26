import 'package:flutter/material.dart';
import 'package:qreader_app/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http'){
    await canLaunch(scan.value) ? await launch(scan.value) : throw 'Could not launch ${scan.value}';

  }else{
    print('Geo');
    Navigator.pushNamed(context, "map", arguments: scan);
  }

}