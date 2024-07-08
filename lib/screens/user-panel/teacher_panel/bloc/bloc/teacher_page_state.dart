part of 'teacher_page_bloc.dart';

class TeacherPageState extends Equatable {
  final TeacherPageStatus teacherPageStatus;
  final String tName;
  final List<UserModel> studentList;
  final List<DocumentModel> documentsList;
  final DocumentListPageStatus documentListPageStatus;

  const TeacherPageState({
    this.tName = "",
    this.teacherPageStatus = TeacherPageStatus.initial,
    this.studentList = const [],
    this.documentsList = const [],
    this.documentListPageStatus = DocumentListPageStatus.initial,
  });

  @override
  List<Object> get props => [
        teacherPageStatus,
        studentList,
        documentListPageStatus,
        documentsList,
        tName
      ];

  TeacherPageState copyWith({
    String? tName,
    TeacherPageStatus? teacherPageStatus,
    List<UserModel>? studentList,
    List<DocumentModel>? documentsList,
    DocumentListPageStatus? documentListPageStatus,
  }) {
    return TeacherPageState(
      tName: tName ?? this.tName,
      teacherPageStatus: teacherPageStatus ?? this.teacherPageStatus,
      studentList: studentList ?? this.studentList,
      documentListPageStatus:
          documentListPageStatus ?? this.documentListPageStatus,
      documentsList: documentsList ?? this.documentsList,
    );
  }
}
