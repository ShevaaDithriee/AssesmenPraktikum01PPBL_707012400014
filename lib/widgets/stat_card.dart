import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.ikon,
    required this.label,
    required this.nilai,
    this.warna,
  });

  final IconData ikon;
  final String label;
  final String nilai;
  final Color? warna;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tema = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ikon, color: warna ?? cs.primary),
            const SizedBox(height: 4),
            Text(nilai, style: tema.titleLarge),
            Text(
              label,
              textAlign: TextAlign.center,
              style: tema.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}