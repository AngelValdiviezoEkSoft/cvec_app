part of 'language_bloc.dart';

class LanguageState extends Equatable {  
  
  final int positionMenu;
  final int positionFormaPago;
  final Locale locale;// = const Locale('en');
  
  const LanguageState(
    {
      positionMenu = 0,
      positionFormaPago = 0,
      locale = const Locale('es')  
    } 
  ) : positionMenu = positionMenu ?? 0,
      positionFormaPago = positionFormaPago ?? 0,
      locale = locale ?? const Locale('es');
  

  LanguageState copyWith({
    int? positionMenu,
    int? positionFormaPago,
    Locale? locale
  }) 
  => LanguageState(
    positionMenu: positionMenu ?? this.positionMenu,
    positionFormaPago: positionFormaPago ?? this.positionFormaPago,
    locale: locale ?? this.locale
  );


  @override
  List<Object> get props => [positionMenu,positionFormaPago, locale];


}