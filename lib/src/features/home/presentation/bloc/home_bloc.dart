import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/features/home/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc(this.repository) : super(HomeState.initial()) {
    on<LoadHomeListing>(_loadListing);
  }

  Future<void> _loadListing(
      LoadHomeListing event, Emitter<HomeState> emit) async {
    final listing = await repository.getListing();
    if (listing.isRight) {
      emit(state.copy(listing: listing.right));
    }
  }
}
