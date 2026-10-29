import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/tema_cubit.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: BlocBuilder<TemaCubit, ThemeMode>(
            builder: (context, modeTema) {
              return SwitchListTile(
                secondary: const Icon(Icons.dark_mode_outlined),
                title: const Text('Mode Gelap'),
                subtitle: const Text('Ganti tampilan terang atau gelap'),
                value: modeTema == ThemeMode.dark,
                onChanged: context.read<TemaCubit>().aturModeGelap,
              );
            },
          ),
        ),
      ],
    );
  }
}