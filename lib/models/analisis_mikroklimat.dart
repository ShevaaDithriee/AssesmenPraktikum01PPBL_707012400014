import 'package:flutter/material.dart';

import 'data_prediksi.dart';

enum StatusMikroklimat {
  kering,
  optimal,
  terlaluLembap;

  String get label {
    switch (this) {
      case StatusMikroklimat.kering:
        return 'Kering';
      case StatusMikroklimat.optimal:
        return 'Optimal';
      case StatusMikroklimat.terlaluLembap:
        return 'Terlalu Lembap';
    }
  }

  Color warna(ColorScheme cs) {
    final gelap = cs.brightness == Brightness.dark;
    switch (this) {
      case StatusMikroklimat.kering:
        return gelap ? Colors.orange.shade300 : Colors.orange.shade900;
      case StatusMikroklimat.optimal:
        return gelap ? Colors.green.shade300 : Colors.green.shade800;
      case StatusMikroklimat.terlaluLembap:
        return gelap ? Colors.blue.shade300 : Colors.blue.shade800;
    }
  }

  IconData get ikon {
    switch (this) {
      case StatusMikroklimat.kering:
        return Icons.wb_sunny;
      case StatusMikroklimat.optimal:
        return Icons.check_circle;
      case StatusMikroklimat.terlaluLembap:
        return Icons.water_drop;
    }
  }
}

class HasilAnalisis {
  const HasilAnalisis({
    required this.status,
    required this.rekomendasi,
    required this.catatanPerawatan,
  });

  final StatusMikroklimat status;
  final String rekomendasi;
  final String catatanPerawatan;
}

class AnalisisMikroklimat {
  AnalisisMikroklimat._();

  static HasilAnalisis analisis(DataPrediksi d) {
    final status = _tentukanStatus(d.kelembapanTanah);

    return HasilAnalisis(
      status: status,
      rekomendasi: _rekomendasi(status),
      catatanPerawatan: _catatanPerawatan(d.tanaman, status),
    );
  }

  static StatusMikroklimat _tentukanStatus(double kelembapanTanah) {
    if (kelembapanTanah < 40) {
      return StatusMikroklimat.kering;
    } else if (kelembapanTanah <= 70) {
      return StatusMikroklimat.optimal;
    } else {
      return StatusMikroklimat.terlaluLembap;
    }
  }

  static String _rekomendasi(StatusMikroklimat status) {
    switch (status) {
      case StatusMikroklimat.kering:
        return 'Segera lakukan penyiraman atau irigasi.';
      case StatusMikroklimat.optimal:
        return 'Pertahankan pola perawatan saat ini.';
      case StatusMikroklimat.terlaluLembap:
        return 'Kurangi penyiraman dan periksa drainase.';
    }
  }

  static String _catatanPerawatan(String tanaman, StatusMikroklimat status) {
    String dasar;
    switch (tanaman) {
      case 'Padi':
        dasar = 'Jaga genangan air 2-5 cm pada fase vegetatif dan keringkan lahan menjelang panen.';
        break;
      case 'Jagung':
        dasar = ',Siram saat tanah mulai kering dan hindari genangan di sekitar perakaran.';
        break;
      case 'Cabai':
        dasar = ',Gunakan mulsa untuk menjaga kelembapan tanah dan siram pada pagi atau sore hari.';
        break;
      default:
        dasar = 'Lakukan pemantauan rutin pada tanaman.';
    }

    switch (status) {
      case StatusMikroklimat.kering:
        return '$dasar Periksa lahan hari ini dan pastikan air tersedia.';
      case StatusMikroklimat.optimal:
        return dasar;
      case StatusMikroklimat.terlaluLembap:
        return '$dasar Waspadai penyakit akibat kelembapan berlebih.';
    }
  }
}