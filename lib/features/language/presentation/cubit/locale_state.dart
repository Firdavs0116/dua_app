import 'dart:ui';

abstract class LocaleState {}

class LocaleInitial extends LocaleState{}

class LocaleChanged extends LocaleState{
  final Locale locale;

  LocaleChanged(this.locale);
}