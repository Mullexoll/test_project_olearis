part of 'olearis_bloc.dart';

@immutable
sealed class OlearisEvent extends Equatable {}

class OlearisAppLoaded extends OlearisEvent {
  @override
  List<Object?> get props => [];
}

class OlearisEmailSubmitted extends OlearisEvent {
  final String emailValue;

  OlearisEmailSubmitted({required this.emailValue});

  @override
  List<Object?> get props => [emailValue];
}

class OlearisPasswordSubmitted extends OlearisEvent {
  final String passwordValue;

  OlearisPasswordSubmitted({
    required this.passwordValue,
  });

  @override
  List<Object?> get props => [passwordValue];
}

class OlearisItemAdded extends OlearisEvent {
  @override
  List<Object?> get props => [];
}

class OlearisItemRemoved extends OlearisEvent {
  @override
  List<Object?> get props => [];
}

class OlearisExceptionResset extends OlearisEvent {
  @override
  List<Object?> get props => [];
}

class OlearisSignInEvent extends OlearisEvent {
  @override
  List<Object?> get props => [];
}
