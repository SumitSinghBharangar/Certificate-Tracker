part of 'teacher_list_page_bloc.dart';

sealed class TeacherListPageEvent extends Equatable {
  const TeacherListPageEvent();

  @override
  List<Object> get props => [];
}

class FetchTeacherListEvent extends TeacherListPageEvent{}

class DeleteTeacherEvent extends TeacherListPageEvent{
  final String id;

  const DeleteTeacherEvent({required this.id});
}
