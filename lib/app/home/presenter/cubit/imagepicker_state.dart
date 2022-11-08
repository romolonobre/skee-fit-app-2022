// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'imagepicker_cubit.dart';

@immutable
abstract class ImagepickerState {}

class ImagepickerLoading extends ImagepickerState {}

class ImagepickerLoaded extends ImagepickerState {
  final File? image;
  ImagepickerLoaded({this.image});
}

class ImagepickerError extends ImagepickerState {
  final String message;
  ImagepickerError({required this.message});
}
