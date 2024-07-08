part of 'student_list_page_bloc.dart';

 class StudentListPageState extends Equatable {
  final StudentListPageStatus studentListPageStatus;
  final List<UserModel> studentList;
  const StudentListPageState({this.studentList = const [],this.studentListPageStatus = StudentListPageStatus.initial});
  
  @override
  List<Object> get props => [studentList,studentListPageStatus];

  StudentListPageState copyWith({
    StudentListPageStatus? studentListPageStatus,
    List<UserModel>? studentList,
  }){
    return StudentListPageState(
      studentList: studentList ?? this.studentList,
      studentListPageStatus: studentListPageStatus ?? this.studentListPageStatus,
    );
  }


}

final class EmptyStudentListState extends StudentListPageState{}

