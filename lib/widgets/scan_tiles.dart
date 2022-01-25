import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {

  const ScanTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    return ListView.builder(
        itemCount: scanListProvider.scans.length,
        itemBuilder: (_, i) => Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {
            Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scanListProvider.scans[i].id!);
          },
          background: Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            color: Colors.red,
          ),
          child: ListTile(
            leading: Icon(scanListProvider.scans[i].tipo == 'geo' ? Icons.map : Icons.http, color: Theme.of(context).primaryColor),
            title: Text(scanListProvider.scans[i].valor),
            subtitle: Text(scanListProvider.scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () => launchURL(context, scanListProvider.scans[i]),
          ),
        )
    );
  }
}
