import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
   
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _document;

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _document = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadDocument() async {
    if (_document == null) return;

    try {
      User? user = _auth.currentUser;
      if (user == null) return;

      // Create a reference to the location where the document will be uploaded
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.pdf';
      Reference ref = _storage.ref().child('documents').child(user.uid).child(fileName);

      // Upload the file to Firebase Storage
      await ref.putFile(_document!);

      // Get the download URL of the uploaded file
      String downloadURL = await ref.getDownloadURL();

      // Save document metadata to Firestore
      await _firestore.collection('users').doc(user.uid).collection('documents').add({
        'file_name': fileName,
        'file_url': downloadURL,
        'uploaded_at': DateTime.now(),
      });

      print("Document uploaded successfully");
    } catch (e) {
      print("Error uploading document: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Document'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickDocument,
              child: Text('Pick Document'),
            ),
            ElevatedButton(
              onPressed: _uploadDocument,
              child: Text('Upload Document'),
            ),
            _document != null ? Text('Selected file: ${_document!.path.split('/').last}') : Container(),
          ],
        ),
      ),
    );
  }
}
