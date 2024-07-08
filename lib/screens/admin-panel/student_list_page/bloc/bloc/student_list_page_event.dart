part of 'student_list_page_bloc.dart';

sealed class StudentListPageEvent extends Equatable {
  const StudentListPageEvent();

  @override
  List<Object> get props => [];
}

class FetchStudentListEvent extends StudentListPageEvent{}

class DeleteStudentEvent extends StudentListPageEvent{
  final String id;

  const DeleteStudentEvent({required this.id});

}
