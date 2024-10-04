import 'package:either_dart/either.dart';
import 'package:real_estate_app/src/data/app_error.dart';

typedef AsyncApiErrorOr<T> = Future<Either<ApiError, T>>;
