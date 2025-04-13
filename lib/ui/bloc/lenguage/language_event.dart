part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class OnNewLanguageEvent extends LanguageEvent {
  final Locale locLang;
  const OnNewLanguageEvent(this.locLang);
}