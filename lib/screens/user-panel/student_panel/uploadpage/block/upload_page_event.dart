import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UploadEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickDocumentEvent extends UploadEvent {}

class UploadDocumentEvent extends UploadEvent {
  final File file;
  final String name;
  final String type;
  final DateTime startdate;
  final DateTime enddate;

  UploadDocumentEvent(
      {required this.file,
      required this.name,
      required this.enddate,
      required this.startdate,
      required this.type});

  @override
  List<Object> get props => [file, name, enddate, startdate, type];
}
