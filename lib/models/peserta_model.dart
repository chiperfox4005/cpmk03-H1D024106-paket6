class Peserta {
  final String nim;
  final String nama;
  final String email;
  final String prodi;
  final DateTime waktuDaftar;
  final bool hadir;

  Peserta({
    required this.nim,
    required this.nama,
    required this.email,
    required this.prodi,
    required this.waktuDaftar,
    this.hadir = false,
  });

  Peserta copyWith({
    String? nim,
    String? nama,
    String? email,
    String? prodi,
    DateTime? waktuDaftar,
    bool? hadir,
  }) {
    return Peserta(
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      prodi: prodi ?? this.prodi,
      waktuDaftar: waktuDaftar ?? this.waktuDaftar,
      hadir: hadir ?? this.hadir,
    );
  }
}