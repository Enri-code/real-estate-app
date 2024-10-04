import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/utils/app_data_types.dart';

abstract class HomeRepository {
  AsyncApiErrorOr<List<HomeListing>> getListing();
}
