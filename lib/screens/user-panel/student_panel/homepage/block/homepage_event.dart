

part of "homepage_bloc.dart";
abstract class HomePageEvents extends Equatable{
  const HomePageEvents();

 @override
  List<Object?> get props => [];
}

class FetchDocuments extends HomePageEvents{}

class LoadDocuments extends HomePageEvents {}

