import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_routes.dart';
import '../models/analisis_mikroklimat.dart';
import '../state/prediksi_cubit.dart';
import '../widgets/prediksi_card.dart';
import '../widgets/stat_card.dart';

class HalamanPrediksi extends StatefulWidget {
  const HalamanPrediksi({super.key});

  @override
  State<HalamanPrediksi> createState() => _HalamanPrediksiState();
}

class _HalamanPrediksiState extends State<HalamanPrediksi> {
  static const List<String> _daftarFilter = [
    PrediksiCubit.semuaPetak,
    'Petak 1',
    'Petak 2',
  ];

  String _petakDipilih = PrediksiCubit.semuaPetak;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<PrediksiCubit, List<RiwayatPrediksi>>(
        builder: (context, semuaData) {
          final cubit = context.read<PrediksiCubit>();
          final daftar = cubit.daftarUntuk(_petakDipilih);

          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Riwayat Prediksi',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  for (final nama in _daftarFilter)
                    Expanded(
                      child: Card(
                        color: nama == _petakDipilih
                            ? cs.secondaryContainer
                            : null,
                        child: InkWell(
                          onTap: () => setState(() => _petakDipilih = nama),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Center(
                              child: Text(
                                nama,
                                style: TextStyle(
                                  fontWeight: nama == _petakDipilih
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: nama == _petakDipilih
                                      ? cs.onSecondaryContainer
                                      : cs.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(
                height: 110,
                child: Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        ikon: Icons.list_alt,
                        label: 'Total',
                        nilai: '${daftar.length}',
                      ),
                    ),
                    Expanded(
                      child: StatCard(
                        ikon: StatusMikroklimat.optimal.ikon,
                        label: 'Optimal',
                        nilai: '${cubit.jumlahOptimal(daftar)}',
                        warna: StatusMikroklimat.optimal.warna(cs),
                      ),
                    ),
                    Expanded(
                      child: StatCard(
                        ikon: Icons.warning_amber,
                        label: 'Perlu Tindakan',
                        nilai: '${cubit.jumlahPerluTindakan(daftar)}',
                        warna: StatusMikroklimat.kering.warna(cs),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (daftar.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('Belum ada data prediksi')),
                )
              else
                for (final item in daftar)
                  PrediksiCard(data: item.data, hasil: item.hasil),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.inputPrediksi),
        icon: const Icon(Icons.add),
        label: const Text('Prediksi Baru'),
      ),
    );
  }
}