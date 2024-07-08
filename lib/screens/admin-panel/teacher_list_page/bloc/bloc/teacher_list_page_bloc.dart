import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../models/student_model.dart';
import '../../../../../utils/enum.dart';

part 'teacher_list_page_event.dart';
part 'teacher_list_page_state.dart';

class TeacherListPageBloc
    extends Bloc<TeacherListPageEvent, TeacherListPageState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TeacherListPageBloc() : super(const TeacherListPageState()) {
    on<FetchTeacherListEvent>(fetchTeacherListEvent);
    on<DeleteTeacherEvent>(deleteTeacherEvent);
  }

  FutureOr<void> fetchTeacherListEvent(
      FetchTeacherListEvent event, Emitter<TeacherListPageState> emit) async {
    emit(state.copyWith(teacherListPageStatus: TeacherListPageStatus.loading));
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('rool', isEqualTo: 'Teacher')
          .get();

      final documents = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data()))
          .toList();
      if (documents.isEmpty) {
        emit(EmptyTeacherListState());
      }
      emit(state.copyWith(
          teacherListPageStatus: TeacherListPageStatus.success,
          teacherList: documents));
    } catch (e) {
      emit(state.copyWith(teacherListPageStatus: TeacherListPageStatus.error));
    }
  }

  FutureOr<void> deleteTeacherEvent(
      DeleteTeacherEvent event, Emitter<TeacherListPageState> emit) async {
    try {
      await _firestore.collection("users").doc(event.id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
