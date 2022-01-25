import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final newScan = new ScanModel(valor: valor);
    final id = await DBProvider.dbProvider.newScan(newScan);

    newScan.id = id;

    if (newScan.tipo == this.tipoSeleccionado) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  cargarScans() async {
    final scans = await DBProvider.dbProvider.getAllScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.dbProvider.getScanByType(tipo);
    this.scans = [...scans!];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.dbProvider.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int i) async {
    await DBProvider.dbProvider.deleteScan(i);
    this.cargarScansPorTipo(this.tipoSeleccionado);
  }
}
