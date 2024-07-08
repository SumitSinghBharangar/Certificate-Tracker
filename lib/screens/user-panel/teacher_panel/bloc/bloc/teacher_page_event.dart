part of 'teacher_page_bloc.dart';

sealed class TeacherPageEvent extends Equatable {
  const TeacherPageEvent();

  @override
  List<Object> get props => [];
}

class DeletebuttonEvent extends TeacherPageEvent {}

class ApproveButtonEvent extends TeacherPageEvent {}

class ListClickEvent extends TeacherPageEvent {
  final String id;

  const ListClickEvent({required this.id});
}

class FetchStudentList extends TeacherPageEvent {}

class FetchTeacherNameEvent extends TeacherPageEvent {}

class UpdateApproveStatusEvent extends TeacherPageEvent {
  final String id;
  
  final Map<String, dynamic> updateData;

  const UpdateApproveStatusEvent({
    required this.id,
    required this.updateData,
    
  });
}
