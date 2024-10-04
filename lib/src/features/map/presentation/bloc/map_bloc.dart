import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/src/utils/enums/map_information.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState.initial()) {
    on<ChangeMarkerInfo>(_changeMarkerInfo);
  }

  void _changeMarkerInfo(ChangeMarkerInfo event, Emitter<MapState> emit) {
    emit(
      state.copy(
        mapInfo: event.information,
      ),
    );
  }
}
