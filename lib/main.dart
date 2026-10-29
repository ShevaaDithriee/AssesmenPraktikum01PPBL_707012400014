import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'app_theme.dart';
import 'pages/halaman_input_prediksi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/kerangka_navigasi.dart';
import 'state/prediksi_cubit.dart';
import 'state/tema_cubit.dart';

void main() => runApp(const AgriClimaApp());

class AgriClimaApp extends StatelessWidget {
  const AgriClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrediksiCubit()),
        BlocProvider(create: (_) => TemaCubit()),
      ],
      child: BlocBuilder<TemaCubit, ThemeMode>(
        builder: (context, modeTema) {
          return MaterialApp(
            title: 'AgriClima',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: modeTema,
            initialRoute: AppRoutes.beranda,
            routes: {
              AppRoutes.beranda: (context) => const KerangkaNavigasi(),
              AppRoutes.tentang: (context) => const HalamanTentang(),
              AppRoutes.inputPrediksi: (context) =>
                  const HalamanInputPrediksi(),
            },
          );
        },
      ),
    );
  }
}