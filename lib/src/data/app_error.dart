import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String message;

  const AppError(this.message);

  static const unknown = AppError('An unknown error has occured');

  @override
  List<Object?> get props => [message];
}

class ApiResponse {
  final Map<String, dynamic>? data;

  const ApiResponse({this.data});
}

class ApiError extends ApiResponse implements AppError {
  @override
  final String message;

  const ApiError({this.message = '', super.data});

  static const socket = ApiError(message: 'You have no internet connection');
  static const timeout = ApiError(
    message: 'Your connection has timed out. Please try again!',
  );
  static const unauthorized = ApiError(
    message: 'Your session has expired.\nYou need to log in again',
  );
  static const unknown = ApiError(
    message: 'There was a problem performing this action',
  );

  @override
  List<Object?> get props => [message, data];

  @override
  bool? get stringify => null;
}
