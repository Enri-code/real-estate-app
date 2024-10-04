part of 'map_bloc.dart';

class MapState extends Equatable {
  final MapInformation mapInfo;

  const MapState({
    required this.mapInfo,
  });

  factory MapState.initial() => const MapState(mapInfo: MapInformation.price);

  MapState copy({MapInformation? mapInfo}) {
    return MapState(mapInfo: mapInfo ?? this.mapInfo);
  }

  @override
  List<Object> get props => [
        mapInfo,
      ];
}
