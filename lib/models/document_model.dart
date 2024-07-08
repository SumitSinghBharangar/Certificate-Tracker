import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentModel {
  final String fileName;
  final String fileUrl;
  final DateTime uploadedAt;
  final String status;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String approvedBy;

  DocumentModel({
    required this.fileName,
    required this.fileUrl,
    required this.uploadedAt,
    required this.status,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.approvedBy,
  });

  factory DocumentModel.fromFirestore(Map<String, dynamic> data) {
    return DocumentModel(
      fileName: data['file_name'],
      fileUrl: data['file_url'],
      uploadedAt: (data['uploaded_at'] as Timestamp).toDate(),
      status: data['status'],
      type: data['type'],
      startDate: (data['start_date'] as Timestamp).toDate(),
      endDate: (data['end_date'] as Timestamp).toDate(),
      approvedBy: data['approved_by'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'file_name': fileName,
      'file_url': fileUrl,
      'uploaded_at': uploadedAt,
      'status': status,
      'type': type,
      'start_date': startDate,
      'end_date': endDate,
      'approved_by': approvedBy,
    };
  }
}
