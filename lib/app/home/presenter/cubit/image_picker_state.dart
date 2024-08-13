// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

abstract class ImagePickerState {}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerLoaded extends ImagePickerState {
  final File? image;
  ImagePickerLoaded({this.image});
}

class ImagePickerError extends ImagePickerState {
  final String message;
  ImagePickerError({required this.message});
}
