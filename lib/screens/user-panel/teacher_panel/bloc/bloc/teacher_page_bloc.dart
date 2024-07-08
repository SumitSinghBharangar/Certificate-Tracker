import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gla_certificate/utils/enum.dart';
import 'package:gla_certificate/utils/utils.dart';

import '../../../../../models/document_model.dart';
import '../../../../../models/student_model.dart';

part 'teacher_page_event.dart';
part 'teacher_page_state.dart';

class TeacherPageBloc extends Bloc<TeacherPageEvent, TeacherPageState> {
  String tName = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TeacherPageBloc() : super(const TeacherPageState()) {
    on<FetchStudentList>(_fetchStudentList);
    on<ListClickEvent>(_listClickEvent);
    on<FetchTeacherNameEvent>(fetchTeacherNameEvent);
    on<UpdateApproveStatusEvent>(updateApproveStatusEvent);
  }

  FutureOr<void> _fetchStudentList(
      FetchStudentList event, Emitter<TeacherPageState> emit) async {
    emit(state.copyWith(teacherPageStatus: TeacherPageStatus.loading));
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('rool', isEqualTo: 'Student')
          .get();

      final documents = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data()))
          .toList();
      if (documents.isEmpty) {}
      emit(state.copyWith(
          teacherPageStatus: TeacherPageStatus.success,
          studentList: documents));
    } catch (e) {
      emit(state.copyWith(teacherPageStatus: TeacherPageStatus.error));
    }
  }

  Future<FutureOr<void>> _listClickEvent(
      ListClickEvent event, Emitter<TeacherPageState> emit) async {
    emit(
        state.copyWith(documentListPageStatus: DocumentListPageStatus.loading));
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(event.id)
          .collection('documents')
          .get();

      final documents = snapshot.docs
          .map((doc) => DocumentModel.fromFirestore(doc.data()))
          .toList();
      if (documents.isEmpty) {}
    } catch (e) {
      emit(
          state.copyWith(documentListPageStatus: DocumentListPageStatus.error));
    }
  }

  FutureOr<void> fetchTeacherNameEvent(
      FetchTeacherNameEvent event, Emitter<TeacherPageState> emit) async {
    try {
      final name = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();
      final tname = name["name"];
      emit(state.copyWith(tName: tname));
    } catch (e) {
      Utils.toastMessage("error while fetching the teacher name");
    }
  }

  FutureOr<void> updateApproveStatusEvent(UpdateApproveStatusEvent event, Emitter<TeacherPageState> emit)async {
    try {
      await _firestore
          .collection('users')
          .doc(event.id)
          .update(event.updateData);

      add(ListClickEvent(id: event.id));
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
