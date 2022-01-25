import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/link_history_page.dart';
import 'package:qr_reader/pages/map_history_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_bottom_navbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .borrarTodos();
            },
            icon: Icon(Icons.delete_forever),
            tooltip: 'Delete all',
          )
        ],
      ),
      body: _HomePageBody(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final scanListProvider = Provider.of<ScanListProvider>(context,
        listen: false); // no se re dibuje cuando hayan cambios.

    final currentIndex = uiProvider.selectedMenuOpt;

    if (currentIndex == 0) {
      scanListProvider.cargarScansPorTipo('geo');
      return MapHistoryPage();
    } else {
      scanListProvider.cargarScansPorTipo('http');
      return LinkHistoryPage();
    }
  }
}
