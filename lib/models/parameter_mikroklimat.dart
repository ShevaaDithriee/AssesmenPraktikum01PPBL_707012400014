import 'package:flutter/material.dart';

class ParameterMikroklimat {
  const ParameterMikroklimat({
    required this.nama,
    required this.satuan,
    required this.deskripsi,
    required this.ikon,
  });

  final String nama;
  final String satuan;
  final String deskripsi;
  final IconData ikon;
}

const List<ParameterMikroklimat> daftarParameter = [
  ParameterMikroklimat(
    nama: 'Suhu Udara',
    satuan: '°C',
    deskripsi: 'Suhu udara di sekitar tanaman.',
    ikon: Icons.thermostat,
  ),
  ParameterMikroklimat(
    nama: 'Kelembapan Udara',
    satuan: '%',
    deskripsi: 'Kadar uap air di udara sekitar tanaman.',
    ikon: Icons.water_drop_outlined,
  ),
  ParameterMikroklimat(
    nama: 'Kelembapan Tanah',
    satuan: '%',
    deskripsi: 'Kadar air pada tanah di area tanam.',
    ikon: Icons.grass,
  ),
];