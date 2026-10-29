import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/analisis_mikroklimat.dart';
import '../models/data_prediksi.dart';
import '../models/validator_prediksi.dart';
import '../state/prediksi_cubit.dart';

class HalamanInputPrediksi extends StatefulWidget {
  const HalamanInputPrediksi({super.key});

  @override
  State<HalamanInputPrediksi> createState() => _HalamanInputPrediksiState();
}

class _HalamanInputPrediksiState extends State<HalamanInputPrediksi> {
  static const List<String> _daftarPetak = ['Petak 1', 'Petak 2'];
  static const List<String> _daftarTanaman = ['Padi', 'Jagung', 'Cabai'];

  final _formKey = GlobalKey<FormState>();
  final _suhuController = TextEditingController();
  final _udaraController = TextEditingController();
  final _tanahController = TextEditingController();
  final _petugasController = TextEditingController();

  String _petak = _daftarPetak.first;
  String? _tanaman;
  bool _dataBenar = false;

  @override
  void dispose() {
    _suhuController.dispose();
    _udaraController.dispose();
    _tanahController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    final data = DataPrediksi(
      petak: _petak,
      tanaman: _tanaman!,
      suhuUdara: ValidatorPrediksi.parseAngka(_suhuController.text)!,
      kelembapanUdara: ValidatorPrediksi.parseAngka(_udaraController.text)!,
      kelembapanTanah: ValidatorPrediksi.parseAngka(_tanahController.text)!,
      namaPetugas: _petugasController.text.trim(),
    );
    final hasil = AnalisisMikroklimat.analisis(data);

    final setuju = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Simpan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${data.petak} - ${data.tanaman}'),
            Text('Suhu udara: ${data.suhuUdara} °C'),
            Text('Kelembapan udara: ${data.kelembapanUdara} %'),
            Text('Kelembapan tanah: ${data.kelembapanTanah} %'),
            Text('Petugas: ${data.namaPetugas}'),
            const SizedBox(height: 8),
            Text(
              'Status: ${hasil.status.label}',
              style: TextStyle(
                color: hasil.status.warna(Theme.of(ctx).colorScheme),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Simpan data ini?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Simpan'),
          ),
        ],
      ),
    );

    if (setuju != true || !mounted) return;

    context.read<PrediksiCubit>().simpan(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data tersimpan')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Input Prediksi')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Petak', style: tema.textTheme.titleMedium),
            for (final p in _daftarPetak)
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(p),
                value: p,
                groupValue: _petak,
                onChanged: (v) => setState(() => _petak = v!),
              ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Nama tanaman',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final t in _daftarTanaman)
                  DropdownMenuItem(value: t, child: Text(t)),
              ],
              onChanged: (v) => setState(() => _tanaman = v),
              validator: ValidatorPrediksi.tanaman,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _suhuController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Prediksi suhu udara',
                suffixText: '°C',
                border: OutlineInputBorder(),
              ),
              validator: ValidatorPrediksi.suhu,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _udaraController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Prediksi kelembapan udara',
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
              validator: ValidatorPrediksi.kelembapan,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _tanahController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Prediksi kelembapan tanah',
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
              validator: ValidatorPrediksi.kelembapan,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _petugasController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama petugas',
                border: OutlineInputBorder(),
              ),
              validator: ValidatorPrediksi.namaPetugas,
            ),
            const SizedBox(height: 8),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Data sudah benar'),
              value: _dataBenar,
              onChanged: (v) => setState(() => _dataBenar = v ?? false),
            ),
            const SizedBox(height: 8),

            FilledButton.icon(
              onPressed: _dataBenar ? _simpan : null,
              icon: const Icon(Icons.save),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}