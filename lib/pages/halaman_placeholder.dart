import 'package:flutter/material.dart';

class HalamanPlaceholder extends StatelessWidget {
  const HalamanPlaceholder({super.key, required this.judul, required this.ikon});

  final String judul;
  final IconData ikon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ikon, size: 64),
          const SizedBox(height: 12),
          Text('Halaman $judul'),
        ],
      ),
    );
  }
}