import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../models/parameter_mikroklimat.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  static const String _lokasiPemantauan =
      'Lahan pertanian (isi nama lokasi, misalnya desa/kecamatan)';

  static const String _tujuanAplikasi =
      'AgriClima membantu petani memantau dan memprediksi kondisi '
      'mikroklimat 24 jam ke depan menggunakan model LSTM, sehingga '
      'keputusan budidaya dapat direncanakan lebih baik.';

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Tujuan Aplikasi', style: tema.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(_tujuanAplikasi),
          const SizedBox(height: 24),

          Text('Lokasi Pemantauan', style: tema.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text(_lokasiPemantauan),
            ),
          ),
          const SizedBox(height: 24),

          Text('Parameter Mikroklimat', style: tema.textTheme.titleLarge),
          const SizedBox(height: 8),
          for (final p in daftarParameter)
            Card(
              child: ListTile(
                leading: Icon(p.ikon),
                title: Text('${p.nama} (${p.satuan})'),
                subtitle: Text(p.deskripsi),
              ),
            ),
          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.inputPrediksi),
            icon: const Icon(Icons.edit_note),
            label: const Text('Ke Input Prediksi'),
          ),
        ],
      ),
    );
  }
}