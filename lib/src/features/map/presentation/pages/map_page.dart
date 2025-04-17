import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/src/core/constants/app_images.dart';
import 'package:real_estate_app/src/core/utils/enums/map_information.dart';
import 'package:real_estate_app/src/features/map/data/models/custom_marker.dart';
import 'package:real_estate_app/src/features/map/presentation/bloc/map_bloc.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/circle_icon_widget.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/custom_marker_widget.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/map_filter_widget.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/map_search_widget.dart';
import 'package:real_estate_app/src/core/theme/app_color.dart';
import 'package:real_estate_app/src/core/widgets/scale_animation_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _controller = Completer<GoogleMapController>();

  String mapTheme = '';

  static const _kGooglePlex = CameraPosition(
    target: LatLng(6.5243793, 3.3792057),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/json/google_map_theme.json')
        .then((theme) {
      if (mounted) setState(() => mapTheme = theme);
      updateAllMarkers();
    });
  }

  List<CustomMarker> markers = [
    CustomMarker(
      position: const LatLng(6.520103824009725, 3.3724523708224297),
      name: '15.22 mn P',
    ),
    CustomMarker(
      position: const LatLng(6.515378337533015, 3.382561951875686),
      name: '11 mn P',
    ),
    CustomMarker(
      position: const LatLng(6.522517848870216, 3.3851150795817375),
      name: '68 mn P',
    ),
    CustomMarker(
      position: const LatLng(6.530884401931502, 3.385053388774395),
      name: '23 mn P',
    ),
    CustomMarker(
      position: const LatLng(6.531641205505422, 3.376055583357811),
      name: '14.5 mn P',
    ),
    CustomMarker(
      position: const LatLng(6.535937176635695, 3.3732349053025246),
      name: '8.67 mn P',
    ),
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
              child: CustomMarkerWidget(text: marker.name),
            );
          }),
          Positioned(
            left: 32.w,
            right: 32.w,
            top: 50.h,
            child: SizedBox(
              height: 48.h,
              child: Row(
                children: [
                  const Expanded(child: MapSearchWidget()),
                  10.horizontalSpace,
                  const AspectRatio(aspectRatio: 1, child: MapFilterWidget()),
                ],
              ),
            ),
          ),
          Positioned(
            left: 32.w,
            bottom: 100.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dropUpWidget(),
                5.verticalSpace,
                const CircleIconWidget(icon: AppImages.send),
              ],
            ),
          ),
          Positioned(
            right: 32.w,
            bottom: 100.h,
            child: ScaleAnimationWidget(
              delay: 100,
              duration: 800,
              child: Container(
                height: 54,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white.withOpacity(0.25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.list,
                      color: Colors.white,
                      width: 16,
                      height: 16,
                    ),
                    6.horizontalSpace,
                    const Text(
                      'List of variants',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<CustomMarker> updateMarkerCoordinates(CustomMarker marker) async {
    final GoogleMapController controller = await _controller.future;
    final coordinate = await controller.getScreenCoordinate(marker.position);
    // ignore: use_build_context_synchronously
    final ratio = MediaQuery.of(context).devicePixelRatio;

    double xAxis = coordinate.x.toDouble() / ratio;
    double yAxis = coordinate.y.toDouble() / ratio;
    return marker.copy(xAxis: xAxis, yAxis: yAxis);
  }

  Widget dropUpWidget() {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const CircleIconWidget(icon: AppImages.wallet),
            onChanged: (info) {
              if (info != null) {
                context.read<MapBloc>().add(ChangeMarkerInfo(info));
              }
            },
            items: MapInformation.values.map((menu) {
              bool selected = state.mapInfo == menu;
              return DropdownMenuItem<MapInformation>(
                value: menu,
                child: Row(
                  children: [
                    Image.asset(
                      menu.icon,
                      width: 18,
                      height: 18,
                      color: selected ? AppColor.primary : AppColor.grey,
                    ),
                    8.horizontalSpace,
                    Text(
                      menu.displayName,
                      style: TextStyle(
                        fontSize: 16,
                        color: selected ? AppColor.primary : AppColor.grey,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            dropdownStyleData: DropdownStyleData(
              width: 180,
              isOverButton: true,
              offset: const Offset(0, 150),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
}
