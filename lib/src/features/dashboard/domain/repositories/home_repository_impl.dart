import 'package:either_dart/either.dart';
import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:real_estate_app/src/utils/app_data_types.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  AsyncApiErrorOr<List<HomeListing>> getListing() async {
    return Right(HomeListing.data);
  }
}
