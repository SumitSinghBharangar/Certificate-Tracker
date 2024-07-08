import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../../utils/enum.dart';

class UploadState extends Equatable {
  final String name;
  final String type;

  final DateTime? startDate;
  final DateTime? endDate;
  final File? file;
  final UploadStatus uploadStatus;

  const UploadState({
    this.file,
    this.uploadStatus = UploadStatus.initail,
    this.name = "",
    this.type = "",
    this.startDate,
    this.endDate,
  });

  UploadState copyWith({
    File? file,
    String? name,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    UploadStatus? uploadStatus,
  }) {
    return UploadState(
      file: file ?? this.file,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      name: name ?? this.name,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props =>
      [file, uploadStatus, name, type, startDate, endDate];
}

class DocumentUploadedSuccessfullyEvent extends UploadState{}


