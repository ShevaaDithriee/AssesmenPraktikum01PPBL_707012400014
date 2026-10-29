class ValidatorPrediksi {
  ValidatorPrediksi._();

  static double? parseAngka(String? teks) {
    final angka = double.tryParse((teks ?? '').trim().replaceAll(',', '.'));
    if (angka == null || !angka.isFinite) return null;
    return angka;
  }

  static String? suhu(String? nilai) {
    if (parseAngka(nilai) == null) return 'Suhu harus berupa angka';
    return null;
  }

  static String? kelembapan(String? nilai) {
    final angka = parseAngka(nilai);
    if (angka == null || angka < 0 || angka > 100) {
      return 'Kelembapan harus berupa angka 0-100';
    }
    return null;
  }

  static String? namaPetugas(String? nilai) {
    if (nilai == null || nilai.trim().isEmpty) {
      return 'Nama petugas tidak boleh kosong';
    }
    return null;
  }

  static String? tanaman(String? nilai) {
    if (nilai == null) return 'Pilih nama tanaman';
    return null;
  }
}