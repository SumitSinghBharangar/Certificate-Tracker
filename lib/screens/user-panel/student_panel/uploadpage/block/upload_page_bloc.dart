import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gla_certificate/screens/user-panel/student_panel/uploadpage/block/upload_page_event.dart';
import 'package:gla_certificate/screens/user-panel/student_panel/uploadpage/block/upload_page_state.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/utils.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UploadBloc() : super(const UploadState()) {
    on<PickDocumentEvent>(pickDocumentEvent);
    on<UploadDocumentEvent>(uploadDocumentEvent);
  }

  FutureOr<void> pickDocumentEvent(
      PickDocumentEvent event, Emitter<UploadState> emit) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);

      emit(state.copyWith(file: file));
    }
    return null;
  }

  FutureOr<void> uploadDocumentEvent(
      UploadDocumentEvent event, Emitter<UploadState> emit) async {
    emit(state.copyWith(uploadStatus: UploadStatus.loading));

    Utils.toastMessage('Uploading your document');

    try {
      User? user = _auth.currentUser;
      if (user == null) return;

      // Create a reference to the location where the document will be uploaded
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.pdf';
      Reference ref =
          _storage.ref().child('documents').child(user.uid).child(fileName);

      // Upload the file to Firebase Storage
      print("file start uploading");
      await ref.putFile(
        event.file,
      );
      print("now getting the download url");

      // Get the download URL of the uploaded file
      String downloadURL = await ref.getDownloadURL();

      Utils.toastMessage("Document uploading");

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('documents')
          .add({
        'file_name': event.name,
        'file_url': downloadURL,
        'uploaded_at': DateTime.now(),
        "status": "pending",
        "type": event.type,
        "start_date": event.startdate,
        "end_date": event.enddate,
        "approved_by": "None"
      });
      Utils.toastMessage("Document uploaded successfully");
      emit(state.copyWith(uploadStatus: UploadStatus.success));
    } on SocketException {
      Utils.toastMessage("Please check your internet connection");
      print("please check your internet connection");
      emit(state.copyWith(uploadStatus: UploadStatus.error));
    } catch (e) {
      print("error uploading document: $e");
      emit(state.copyWith(uploadStatus: UploadStatus.error));
    }
  }
}
