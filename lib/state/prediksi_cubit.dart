import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/analisis_mikroklimat.dart';
import '../models/data_prediksi.dart';

class RiwayatPrediksi {
  const RiwayatPrediksi({required this.data, required this.hasil});

  final DataPrediksi data;
  final HasilAnalisis hasil;
}

class PrediksiCubit extends Cubit<List<RiwayatPrediksi>> {
  PrediksiCubit() : super(const []);

  static const String semuaPetak = 'Semua';

  void simpan(DataPrediksi data) {
    final hasil = AnalisisMikroklimat.analisis(data);
    emit([RiwayatPrediksi(data: data, hasil: hasil), ...state]);
  }

  List<RiwayatPrediksi> daftarUntuk(String petak) {
    if (petak == semuaPetak) return state;
    return state.where((e) => e.data.petak == petak).toList();
  }

  int jumlahOptimal(List<RiwayatPrediksi> daftar) =>
      daftar.where((e) => e.hasil.status == StatusMikroklimat.optimal).length;

  int jumlahPerluTindakan(List<RiwayatPrediksi> daftar) =>
      daftar.where((e) => e.hasil.status != StatusMikroklimat.optimal).length;
}