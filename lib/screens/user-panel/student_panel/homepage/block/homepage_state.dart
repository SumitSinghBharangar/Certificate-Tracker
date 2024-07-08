part of "homepage_bloc.dart";

class HomePageState extends Equatable {
  final HomePageStatus homePageStatus;
  final List<DocumentModel> documents;

  const HomePageState({
    this.homePageStatus = HomePageStatus.initail,
    this.documents = const [],
  });

  HomePageState copyWith({
    List<DocumentModel>? documents,
    HomePageStatus? homePageStatus,
  }) {
    return HomePageState(
      homePageStatus: homePageStatus ?? this.homePageStatus,
      documents: documents?? this.documents,
    );
  }

  @override
  List<Object?> get props => [homePageStatus,documents];
}

// class DocumentInitial extends HomePageState {}

// class DocumentLoadInProgress extends HomePageState {}

// class DocumentLoadSuccess extends HomePageState {
  
//   final List<DocumentModel> documents;

//   DocumentLoadSuccess({required this.documents});

//   @override
//   List<Object> get props => [documents];
// }

// class DocumentLoadFailure extends HomePageState {}
