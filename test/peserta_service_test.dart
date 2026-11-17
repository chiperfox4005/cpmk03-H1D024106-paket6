import 'dart:io';
import 'package:cpmk3_seminar/models/peserta_adapter.dart';
import 'package:cpmk3_seminar/models/peserta_model.dart';
import 'package:cpmk3_seminar/services/peserta_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  late Directory dir;
  final service = PesertaService();

  setUpAll(() async {
    dir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(dir.path);
    Hive.registerAdapter(PesertaAdapter());
    await Hive.openBox<Peserta>(PesertaService.boxName);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
    await dir.delete(recursive: true);
  });

  final peserta1 = Peserta(nim: 'H1D024106', nama: 'Fikry Mumtaz Pratama', email: 'fikry@example.com', prodi: 'Informatika', waktuDaftar: DateTime.now(), hadir: false);

  test('CREATE & READ', () async {
    await service.create(peserta1);
    final all = service.getAll();
    expect(all.length, 1);
    expect(all.first.nama, 'Fikry Mumtaz Pratama');
  });

  test('UPDATE', () async {
    final updated = peserta1.copyWith(nama: 'Fikry Updated', hadir: true);
    await service.update(updated);
    final all = service.getAll();
    expect(all.first.nama, 'Fikry Updated');
    expect(all.first.hadir, true);
  });

  test('DELETE', () async {
    await service.delete('H1D024106');
    expect(service.getAll(), isEmpty);
  });
}