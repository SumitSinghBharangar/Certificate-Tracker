import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../models/document_model.dart';

import '../../../../../repositories/fetch_details.dart';
import '../../../../../utils/enum.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FetchDocumentRepository fetchDocumentRepository = FetchDocumentRepository();

  HomePageBloc() : super(const HomePageState()) {
    on<FetchDocuments>(fetchDocuments);
  }

  FutureOr<void> fetchDocuments(
      FetchDocuments event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(homePageStatus: HomePageStatus.loading));

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('documents')
          .get();

      final documents = snapshot.docs
          .map((doc) => DocumentModel.fromFirestore(doc.data()))
          .toList();
      if (documents.isEmpty) {}
      emit(state.copyWith(
          homePageStatus: HomePageStatus.success, documents: documents));
    } catch (e) {
      emit(const HomePageState(homePageStatus: HomePageStatus.error));
    }
  }
}
