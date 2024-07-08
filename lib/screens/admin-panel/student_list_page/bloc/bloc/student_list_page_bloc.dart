import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gla_certificate/utils/utils.dart';

import '../../../../../models/student_model.dart';
import '../../../../../utils/enum.dart';

part 'student_list_page_event.dart';
part 'student_list_page_state.dart';

class StudentListPageBloc
    extends Bloc<StudentListPageEvent, StudentListPageState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StudentListPageBloc() : super(const StudentListPageState()) {
    on<FetchStudentListEvent>(fetchStudentListEvent);
    on<DeleteStudentEvent>(deleteStudentEvent);
  }

  FutureOr<void> fetchStudentListEvent(
      FetchStudentListEvent event, Emitter<StudentListPageState> emit) async {
    emit(state.copyWith(studentListPageStatus: StudentListPageStatus.loading));
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('rool', isEqualTo: 'Student')
          .get();

      final documents = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data()))
          .toList();
      if (documents.isEmpty) {
        emit(EmptyStudentListState());
      }
      emit(state.copyWith(
          studentListPageStatus: StudentListPageStatus.success,
          studentList: documents));
    } catch (e) {
      print(e.toString());
      
      emit(state.copyWith(studentListPageStatus: StudentListPageStatus.error));
    }
  }

  FutureOr<void> deleteStudentEvent(
      DeleteStudentEvent event, Emitter<StudentListPageState> emit) async {
    try {
      await _firestore.collection("users").doc(event.id).delete();
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
