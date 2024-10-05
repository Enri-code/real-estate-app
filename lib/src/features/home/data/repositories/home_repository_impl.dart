import 'package:either_dart/either.dart';
import 'package:real_estate_app/src/features/home/data/models/home_listing.dart';
import 'package:real_estate_app/src/features/home/domain/repositories/home_repository.dart';
import 'package:real_estate_app/src/utils/app_data_types.dart';

class HomeRepositoryImpl extends HomeRepository {
  static const List<HomeListing> data = [
    HomeListing(
      image: 'assets/images/home/home_img_1.png',
      text: 'Gladkova St., 25',
    ),
    HomeListing(
      image: 'assets/images/home/home_img_2.png',
      text: 'Gubina St., 11',
    ),
    HomeListing(
      image: 'assets/images/home/home_img_4.png',
      text: 'Trefoleva St., 43',
    ),
    HomeListing(
      image: 'assets/images/home/home_img_3.png',
      text: 'Sedova St., 22',
    ),
  ];

  @override
  AsyncApiErrorOr<List<HomeListing>> getListing() async {
    return const Right(data);
  }
}
