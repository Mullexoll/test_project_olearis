part of 'olearis_bloc.dart';

@immutable
sealed class OlearisState extends Equatable {}

final class OlearisInitial extends OlearisState {
  @override
  List<Object?> get props => [];
}

final class OlearisStateLoaded extends OlearisState {
  final String emailValue;
  final String passwordValue;
  final List<String> listItems;
  final AppException? appException;
  final bool signInIsLoading;

  OlearisStateLoaded({
    required this.emailValue,
    required this.passwordValue,
    required this.listItems,
    required this.appException,
    required this.signInIsLoading,
  });

  OlearisStateLoaded copyWith({
    String? emailValue,
    String? passwordValue,
    List<String>? listItems,
    AppException? appException,
    bool? signInIsLoading,
  }) {
    return OlearisStateLoaded(
      emailValue: emailValue ?? this.emailValue,
      passwordValue: passwordValue ?? this.passwordValue,
      listItems: listItems ?? this.listItems,
      appException: appException,
      signInIsLoading: signInIsLoading ?? this.signInIsLoading,
    );
  }

  @override
  List<Object?> get props => [
        emailValue,
        passwordValue,
        listItems,
        appException,
        signInIsLoading,
      ];
}
