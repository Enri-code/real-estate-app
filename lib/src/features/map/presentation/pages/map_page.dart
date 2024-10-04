import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/src/data/app_images.dart';
import 'package:real_estate_app/src/utils/enums/map_information.dart';
import 'package:real_estate_app/src/features/map/data/models/custom_marker.dart';
import 'package:real_estate_app/src/features/map/presentation/bloc/map_bloc.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/circle_icon_widget.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/custom_marker_widget.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/map_filter_widget.dart';
import 'package:real_estate_app/src/features/map/presentation/widgets/map_search_widget.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/ui/scale_animation_widget.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final theme = await DefaultAssetBundle.of(context)
          .loadString('assets/json/google_map_theme.json');

      if (mounted) setState(() => mapTheme = theme);
      updateAllMarkers();
    });
  }

  List<CustomMarker> markers = [
    CustomMarker(
      position: const LatLng(6.538937012067466, 3.373223618378729),
      name: 'Yaba2 College',
    ),
    // CustomMarker(
    //   position: const LatLng(6.508937012067466, 3.383223618378729),
    //   name: 'Yaba2 College',
    // ),
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
          Positioned(
            left: 20.w,
            right: 20.w,
            top: 50.h,
            child: SizedBox(
              height: 45.h,
              child: Row(
                children: [
                  const Expanded(
                    child: MapSearchWidget(),
                  ),
                  10.horizontalSpace,
                  const AspectRatio(
                    aspectRatio: 1,
                    child: MapFilterWidget(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.w,
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
            right: 20.w,
            bottom: 100.h,
            child: ScaleAnimationWidget(
              delay: 1800,
              duration: 500,
              child: Container(
                height: 50.r,
                width: 150.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.list,
                      color: Colors.white,
                      width: 15.r,
                      height: 15.r,
                    ),
                    5.horizontalSpace,
                    const Text(
                      'List of variants',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
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
                      width: 15.r,
                      height: 15.r,
                      color: selected ? AppColor.primary : AppColor.grey,
                    ),
                    5.horizontalSpace,
                    Text(
                      menu.displayName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: selected ? AppColor.primary : AppColor.grey,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            dropdownStyleData: DropdownStyleData(
              width: 180.w,
              isOverButton: true,
              offset: const Offset(0, 150),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
