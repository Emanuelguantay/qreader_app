import 'package:qreader_app/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(ScanModel scan) async {
  if (scan.type == 'http'){
    await canLaunch(scan.value) ? await launch(scan.value) : throw 'Could not launch ${scan.value}';

  }else{
    print('Geo');
  }
}