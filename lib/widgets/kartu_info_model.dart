import 'package:flutter/material.dart';

class KartuInfoModel extends StatelessWidget {
  const KartuInfoModel({
    super.key,
    required this.namaModel,
    required this.rentangPrediksi,
    required this.jumlahParameter,
  });

  final String namaModel;
  final String rentangPrediksi;
  final int jumlahParameter;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Info Model', style: tema.textTheme.titleLarge),
            const Divider(height: 24),
            _baris(Icons.memory, 'Model', namaModel),
            _baris(Icons.schedule, 'Prediksi', rentangPrediksi),
            _baris(Icons.thermostat, 'Parameter',
                '$jumlahParameter parameter mikroklimat'),
          ],
        ),
      ),
    );
  }

  Widget _baris(IconData ikon, String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(ikon, size: 20),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(nilai)),
        ],
      ),
    );
  }
}