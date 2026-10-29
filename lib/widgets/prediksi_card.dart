import 'package:flutter/material.dart';

import '../models/analisis_mikroklimat.dart';
import '../models/data_prediksi.dart';

class PrediksiCard extends StatelessWidget {
  const PrediksiCard({super.key, required this.data, required this.hasil});

  final DataPrediksi data;
  final HasilAnalisis hasil;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final warna = hasil.status.warna(cs);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(hasil.status.ikon, color: warna),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${data.petak} - ${data.tanaman}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  hasil.status.label,
                  style: TextStyle(color: warna, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Suhu udara: ${data.suhuUdara} °C'),
            Text('Kelembapan udara: ${data.kelembapanUdara} %'),
            Text('Kelembapan tanah: ${data.kelembapanTanah} %'),
            const SizedBox(height: 8),
            Text('Rekomendasi: ${hasil.rekomendasi}'),
            Text('Catatan: ${hasil.catatanPerawatan}'),
            Text('Petugas: ${data.namaPetugas}'),
          ],
        ),
      ),
    );
  }
}