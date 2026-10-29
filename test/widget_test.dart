import 'package:flutter_test/flutter_test.dart';

import 'package:agriclima_lstm_707012400014/main.dart';

void main() {
  testWidgets('Beranda tampil dengan teks Selamat Datang', (tester) async {
    await tester.pumpWidget(const AgriClimaApp());

    expect(find.text('Selamat Datang'), findsOneWidget);
    expect(find.text('AgriClima - Beranda'), findsOneWidget);
  });
}