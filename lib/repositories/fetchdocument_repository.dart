import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FetchDocumentRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<DocumentSnapshot>> fetchDocuments() async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("User not authenticated");
    }
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('documents')
        .get();

    return querySnapshot.docs;
  }
}
