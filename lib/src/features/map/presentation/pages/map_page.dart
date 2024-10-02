import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String mapTheme = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.5243793, 3.3792057),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DefaultAssetBundle.of(context)
          .loadString('assets/json/google_map_theme.json')
          .then((theme) {
        setState(() {
          mapTheme = theme;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            style: mapTheme,
            initialCameraPosition: _kGooglePlex,
            markers: {
              Marker(
                markerId: MarkerId('value'),
                icon: BitmapDescriptor.defaultMarker,
              ),
            },
          ),
        ],
      ),
    );
  }
}
