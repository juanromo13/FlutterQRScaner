import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  MapType maptype = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _startPosition = CameraPosition(
      target: scan.getLatLng(),
      zoom: 16,
    );

    Set<Marker> markers = new Set<Marker>();
    markers.add(
        Marker(markerId: MarkerId('location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Map'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (maptype == MapType.normal) {
                    maptype = MapType.hybrid;
                  } else {
                    maptype = MapType.normal;
                  }
                });
              },
              icon: Icon(Icons.layers))
        ],
      ),
      body: GoogleMap(
        mapType: maptype,
        markers: markers,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _startPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: scan.getLatLng(),
            zoom: 16,
          )));
        },
        label: Text('location'),
        icon: Icon(Icons.fmd_good),
      ),
    );
  }
}
