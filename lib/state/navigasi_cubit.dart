import 'package:flutter_bloc/flutter_bloc.dart';

class NavigasiCubit extends Cubit<int> {
  NavigasiCubit() : super(0);

  void pilihTab(int indeks) {
    if (indeks != state) emit(indeks);
  }
}