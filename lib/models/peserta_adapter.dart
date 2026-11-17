import 'package:hive/hive.dart';
import 'peserta_model.dart';

class PesertaAdapter extends TypeAdapter<Peserta> {
  @override
  final int typeId = 6; // typeId unik sesuai instruksi Paket 6

  @override
  Peserta read(BinaryReader reader) {
    return Peserta(
      nim: reader.readString(),
      nama: reader.readString(),
      email: reader.readString(),
      prodi: reader.readString(),
      waktuDaftar: reader.readDateTime(),
      hadir: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Peserta obj) {
    writer.writeString(obj.nim);
    writer.writeString(obj.nama);
    writer.writeString(obj.email);
    writer.writeString(obj.prodi);
    writer.writeDateTime(obj.waktuDaftar);
    writer.writeBool(obj.hadir);
  }
}