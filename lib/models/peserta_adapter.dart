import 'package:hive/hive.dart';
import 'peserta_model.dart';

class PesertaAdapter extends TypeAdapter<Peserta> {
  @override
  final int typeId = 6;

  @override
  Peserta read(BinaryReader reader) {
    return Peserta(
      nim: reader.readString(),
      nama: reader.readString(),
      email: reader.readString(),
      prodi: reader.readString(),
      // Baca sebagai int, lalu ubah kembali menjadi DateTime
      waktuDaftar: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      hadir: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Peserta obj) {
    writer.writeString(obj.nim);
    writer.writeString(obj.nama);
    writer.writeString(obj.email);
    writer.writeString(obj.prodi);
    // Simpan DateTime sebagai int (milliseconds)
    writer.writeInt(obj.waktuDaftar.millisecondsSinceEpoch);
    writer.writeBool(obj.hadir);
  }
}