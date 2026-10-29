import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/navigasi_cubit.dart';
import 'halaman_beranda.dart';
import 'halaman_placeholder.dart';
import 'halaman_prediksi.dart';
import 'halaman_pengaturan.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  final NavigasiCubit _navigasiCubit = NavigasiCubit();

  static const List<String> _namaTab = [
    'Beranda',
    'Prediksi',
    'Statistik',
    'Pengaturan',
  ];

  static const List<Widget> _halaman = [
    HalamanBeranda(),
    HalamanPrediksi(),
    HalamanPlaceholder(judul: 'Statistik', ikon: Icons.bar_chart),
    HalamanPengaturan(),
  ];

  @override
  void dispose() {
    _navigasiCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _navigasiCubit,
      child: BlocBuilder<NavigasiCubit, int>(
        builder: (context, indeksAktif) {
          return Scaffold(
            appBar: AppBar(
              title: Text('AgriClima - ${_namaTab[indeksAktif]}'),
            ),
            body: IndexedStack(index: indeksAktif, children: _halaman),
            bottomNavigationBar: NavigationBar(
              selectedIndex: indeksAktif,
              onDestinationSelected: _navigasiCubit.pilihTab,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.insights_outlined),
                  selectedIcon: Icon(Icons.insights),
                  label: 'Prediksi',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Statistik',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Pengaturan',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}