import 'package:flutter/material.dart';
import 'package:qreader_app/src/bloc/scans_bloc.dart';
import 'package:qreader_app/src/models/scan_model.dart';
import 'package:qreader_app/src/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {

    scansBloc.getScanAll();
    return StreamBuilder<List<ScanModel>>(
        stream: scansBloc.scansStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('No hay información'),
            );
          }

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
              child: ListTile(
                leading: Icon(Icons.map,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[i].value),
                subtitle: Text('ID: ${scans[i].id}'),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: (){utils.openScan(context, scans[i]);},
              ),
            ),
          );
        });
  }
}
