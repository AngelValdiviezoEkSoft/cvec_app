import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  
  int positionMenu = 0;
  int positionFormaPago = 0;
  Locale locale = const Locale('en');

  LanguageBloc() : super(const LanguageState(
    positionMenu: 0, positionFormaPago: 0, locale: Locale('en'))) {    
    on<OnNewLanguageEvent>(_onReInitLanguage);
  }

  void _onReInitLanguage( OnNewLanguageEvent event, Emitter<LanguageState> emit ) {
    emit( state.copyWith( positionMenu: positionMenu ) );
  }

  void setLanguage(Locale lang) {
    locale = lang;
    add(OnNewLanguageEvent(lang));
  }  

  @override
  //ignore: unnecessary_overrides
  Future<void> close() {
    return super.close();
  }

}


 