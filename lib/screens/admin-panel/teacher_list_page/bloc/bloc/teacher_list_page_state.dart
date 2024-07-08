part of 'teacher_list_page_bloc.dart';

class TeacherListPageState extends Equatable {
  final TeacherListPageStatus teacherListPageStatus;
  final List<UserModel> teacherList;
  const TeacherListPageState({
    this.teacherListPageStatus = TeacherListPageStatus.initial,
    this.teacherList = const [],
  });

  @override
  List<Object> get props => [teacherListPageStatus, teacherList];

  TeacherListPageState copyWith({
    TeacherListPageStatus? teacherListPageStatus,
    List<UserModel>? teacherList,
  }) {
    return TeacherListPageState(
        teacherList: teacherList ?? this.teacherList,
        teacherListPageStatus:
            teacherListPageStatus ?? this.teacherListPageStatus);
  }
}

final class EmptyTeacherListState extends TeacherListPageState {}
