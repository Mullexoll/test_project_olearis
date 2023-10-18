import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:olearis_flutter/domain/exceptions/app_exceptions.dart';

part 'olearis_event.dart';
part 'olearis_state.dart';

class OlearisBloc extends Bloc<OlearisEvent, OlearisState> {
  int itemIndex = 1;

  OlearisBloc() : super(OlearisInitial()) {
    on<OlearisAppLoaded>(_onOlearisAppLoaded);
    on<OlearisEmailSubmitted>(_onOlearisEmailSubmitted);
    on<OlearisPasswordSubmitted>(_onOlearisPasswordSubmitted);
    on<OlearisItemAdded>(_onOlearisItemAdded);
    on<OlearisItemRemoved>(_onOlearisItemRemoved);
    on<OlearisExceptionResset>(_onOlearisExceptionResset);
    on<OlearisSignInEvent>(_onOlearisSignInEvent);
  }

  FutureOr<void> _onOlearisAppLoaded(
    OlearisAppLoaded event,
    Emitter<OlearisState> emit,
  ) {
    emit(
      OlearisStateLoaded(
        emailValue: '',
        passwordValue: '',
        listItems: List.from([]),
        appException: null,
        signInIsLoading: false,
      ),
    );
  }

  FutureOr<void> _onOlearisEmailSubmitted(
    OlearisEmailSubmitted event,
    Emitter<OlearisState> emit,
  ) {
    emit(
      (state as OlearisStateLoaded).copyWith(
        emailValue: event.emailValue,
      ),
    );
  }

  FutureOr<void> _onOlearisPasswordSubmitted(
    OlearisPasswordSubmitted event,
    Emitter<OlearisState> emit,
  ) {
    emit(
      (state as OlearisStateLoaded).copyWith(
        passwordValue: event.passwordValue,
      ),
    );
  }

  FutureOr<void> _onOlearisItemAdded(
    OlearisItemAdded event,
    Emitter<OlearisState> emit,
  ) {
    if (state is OlearisStateLoaded) {
      final List<String> listItems =
          List.of((state as OlearisStateLoaded).listItems);

      final List<String> newEmmitedList = listItems..add('Item $itemIndex');
      itemIndex++;

      emit(
        (state as OlearisStateLoaded).copyWith(
          listItems: newEmmitedList,
          appException: null,
        ),
      );
    }
  }

  FutureOr<void> _onOlearisItemRemoved(
    OlearisItemRemoved event,
    Emitter<OlearisState> emit,
  ) {
    if (state is OlearisStateLoaded) {
      final List<String> listItems =
          List.of((state as OlearisStateLoaded).listItems);

      if (listItems.isEmpty) {
        emit(
          (state as OlearisStateLoaded).copyWith(
            appException: EmtyListException(),
          ),
        );
      } else {
        final List<String> newEmmitedList = listItems..removeLast();
        itemIndex--;

        emit(
          (state as OlearisStateLoaded).copyWith(listItems: newEmmitedList),
        );
      }
    }
  }

  FutureOr<void> _onOlearisExceptionResset(
    OlearisExceptionResset event,
    Emitter<OlearisState> emit,
  ) {
    emit(
      (state as OlearisStateLoaded).copyWith(appException: null),
    );
  }

  FutureOr<void> _onOlearisSignInEvent(
    OlearisSignInEvent event,
    Emitter<OlearisState> emit,
  ) async {
    emit((state as OlearisStateLoaded).copyWith(signInIsLoading: true));
    await Future.delayed(const Duration(seconds: 4));
    emit((state as OlearisStateLoaded).copyWith(signInIsLoading: false));
  }
}
