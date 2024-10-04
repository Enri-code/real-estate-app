part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<HomeListing> listing;
  const HomeState({required this.listing});

  factory HomeState.initial() => const HomeState(listing: []);

  HomeState copy({List<HomeListing>? listing}) => HomeState(
        listing: listing ?? this.listing,
      );

  @override
  List<Object> get props => [listing];
}
