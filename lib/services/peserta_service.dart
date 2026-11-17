import 'package:hive/hive.dart';
import '../models/peserta_model.dart';

class PesertaService {
  static const String boxName = 'peserta_box';

  Box<Peserta> get _box => Hive.box<Peserta>(boxName);

  List<Peserta> getAll() {
    return _box.values.toList();
  }

  Future<void> create(Peserta peserta) async {
    await _box.put(peserta.nim, peserta);
  }

  Future<void> update(Peserta peserta) async {
    await _box.put(peserta.nim, peserta);
  }

  Future<void> delete(String nim) async {
    await _box.delete(nim);
  }
}