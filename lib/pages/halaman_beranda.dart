import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../widgets/kartu_info_model.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang di AgriClima LSTM',
            style: tema.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const KartuInfoModel(
            namaModel: 'LSTM',
            rentangPrediksi: '24 jam ke depan',
            jumlahParameter: 3,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.tentang),
              icon: const Icon(Icons.info_outline),
              label: const Text('Tentang'),
            ),
          ),
        ],
      ),
    );
  }
}