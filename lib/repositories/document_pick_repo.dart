import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DocumentRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<File?> pickDocument() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      return file;
    }
    return null;
  }

  Future<void> uploadDocument(
    File? file,
    String? name,
    String? type,
    DateTime? startdate,
    DateTime? enddate,
  ) async {
    if (file == null) return;

    try {
      User? user = _auth.currentUser;
      if (user != null) return;

      // Create a reference to the location where the document will be uploaded
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.pdf';
      Reference ref =
          _storage.ref().child('documents').child(user!.uid).child(fileName);

      // Upload the file to Firebase Storage
      await ref.putFile(file);

      // Get the download URL of the uploaded file
      String downloadURL = await ref.getDownloadURL();

      // Save document metadata to Firestore
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('documents')
          .add({
        'file_name': name,
        'file_url': downloadURL,
        'uploaded_at': DateTime.now(),
        "status": "pending",
        "type": type,
        "start_date": startdate,
        "end_date": enddate,
      });

      print("Document uploaded successfully");
    } catch (e) {
      print("Error uploading document: $e");
    }
  }
}
