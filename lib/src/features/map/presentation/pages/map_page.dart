import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/src/features/map/data/models/custom_marker.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/custom_marker_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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
        updateAllMarkers();
      });
    });
  }

  List<CustomMarker> markers = [
    CustomMarker(
      position: const LatLng(6.538937012067466, 3.373223618378729),
      name: 'Yaba2 College',
    ),
    CustomMarker(
      position: const LatLng(6.508937012067466, 3.383223618378729),
      name: 'Yaba2 College',
    ),
    CustomMarker(
      position: const LatLng(6.518937012067466, 3.373223618378729),
      name: 'Yaba College',
    ),
    CustomMarker(
      position: const LatLng(6.522691546522795, 3.369129819908472),
      name: 'Onoyade Street',
    ),
    CustomMarker(
      position: const LatLng(6.521991544648042, 3.375833154153196),
      name: 'Hussey Road',
    ),
    CustomMarker(
      position: const LatLng(6.518236985614774, 3.378510423737504),
      name: 'Club Road',
    ),
    // CustomMarker(
    //   position: const LatLng(6.605600625311391, 3.37533474350852),
    //   name: 'Somolu Road',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            style: mapTheme,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
            onCameraMove: (camPosition) {
              updateAllMarkers();
            },
          ),
          ...markers.map((marker) {
            return Positioned(
              top: marker.yAxis,
              left: marker.xAxis,
              child: CustomMarkerWidget(
                text: marker.name,
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> updateAllMarkers() async {
    final futures = markers.map((marker) async {
      return await updateMarkerCoordinates(marker);
    }).toList();

    final allMarkers = await Future.wait(futures);
    markers = allMarkers;
    // update marker positions
    setState(() {});
  }

  Future<CustomMarker> updateMarkerCoordinates(CustomMarker marker) async {
    final GoogleMapController controller = await _controller.future;
    final coordinate = await controller.getScreenCoordinate(
      marker.position,
    );
    // ignore: use_build_context_synchronously
    final ratio = MediaQuery.of(context).devicePixelRatio;

    double xAxis = coordinate.x.toDouble() / ratio;
    double yAxis = coordinate.y.toDouble() / ratio;
    return marker.copy(xAxis: xAxis, yAxis: yAxis);
  }
}
