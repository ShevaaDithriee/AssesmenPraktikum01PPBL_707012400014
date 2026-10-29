import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemaCubit extends Cubit<ThemeMode> {
  TemaCubit() : super(ThemeMode.light);

  void aturModeGelap(bool aktif) {
    emit(aktif ? ThemeMode.dark : ThemeMode.light);
  }
}