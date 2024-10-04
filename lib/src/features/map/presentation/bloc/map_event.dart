part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class ChangeMarkerInfo extends MapEvent {
  const ChangeMarkerInfo(this.information);

  final MapInformation information;
}
