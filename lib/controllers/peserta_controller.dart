import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/peserta_model.dart';
import '../routes/app_routes.dart';
import '../services/peserta_service.dart';

class PesertaController extends GetxController {
  final PesertaService _service = PesertaService();

  final pesertaList = <Peserta>[].obs;
  final keyword = ''.obs;
  final filterStatus = 'Semua'.obs;

  final formKey = GlobalKey<FormState>();
  final nimC = TextEditingController();
  final namaC = TextEditingController();
  final emailC = TextEditingController();
  final prodiC = ''.obs;

  final List<String> daftarProdi = const ['Informatika', 'Sistem Informasi', 'Teknik Elektro'];

  String? editingNim;
  bool get isEdit => editingNim != null;

  List<Peserta> get displayList {
    List<Peserta> list = pesertaList.toList();
    if (filterStatus.value == 'Hadir') list = list.where((p) => p.hadir).toList();
    else if (filterStatus.value == 'Belum Hadir') list = list.where((p) => !p.hadir).toList();

    final q = keyword.value.toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((p) => p.nama.toLowerCase().contains(q) || p.nim.contains(q)).toList();
    }
    list.sort((a, b) => b.waktuDaftar.compareTo(a.waktuDaftar));
    return list;
  }

  int get totalHadir => pesertaList.where((p) => p.hadir).length;
  int get totalPeserta => pesertaList.length;
  String get statistikText => 'Hadir $totalHadir/$totalPeserta';

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    pesertaList.assignAll(_service.getAll());
  }

  void openAddForm() {
    editingNim = null;
    nimC.clear(); namaC.clear(); emailC.clear();
    prodiC.value = daftarProdi.first;
    Get.toNamed(AppRoutes.form);
  }

  void openEditForm(Peserta p) {
    editingNim = p.nim;
    nimC.text = p.nim; namaC.text = p.nama; emailC.text = p.email;
    prodiC.value = p.prodi;
    Get.toNamed(AppRoutes.form);
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    final nim = nimC.text.trim();
    if (pesertaList.any((p) => p.nim == nim && p.nim != editingNim)) {
      Get.snackbar('Gagal', 'NIM $nim sudah terdaftar', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final existing = isEdit ? pesertaList.firstWhere((p) => p.nim == editingNim) : null;
    final peserta = Peserta(
      nim: nim, nama: namaC.text.trim(), email: emailC.text.trim(), prodi: prodiC.value,
      waktuDaftar: isEdit ? existing!.waktuDaftar : DateTime.now(),
      hadir: isEdit ? existing!.hadir : false,
    );

    if (isEdit) await _service.update(peserta);
    else await _service.create(peserta);

    loadData();
    tutup();
    Get.snackbar('Sukses', isEdit ? 'Data diperbarui' : 'Data ditambahkan', snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> confirmDelete(Peserta p) async {
    final yakin = await Get.dialog<bool>(AlertDialog(
      title: const Text('Hapus Data'),
      content: Text('Yakin ingin menghapus data ${p.nama}?'),
      actions: [
        TextButton(onPressed: () => tutup(false), child: const Text('Batal')),
        FilledButton(onPressed: () => tutup(true), child: const Text('Hapus')),
      ],
    ));
    if (yakin == true) {
      await _service.delete(p.nim);
      loadData();
      Get.snackbar('Terhapus', '${p.nama} telah dihapus', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> toggleHadir(Peserta p) async {
    await _service.update(p.copyWith(hadir: !p.hadir));
    loadData();
  }

  void setFilter(String status) => filterStatus.value = status;
  void tutup<T>([T? result]) => Get.key.currentState?.pop<T>(result);

  String? validateNim(String? v) {
    if (v == null || v.trim().isEmpty) return 'NIM wajib diisi';
    if (int.tryParse(v.trim()) == null) return 'NIM harus berupa angka';
    if (v.trim().length < 8 || v.trim().length > 12) return 'NIM harus 8-12 digit';
    return null;
  }
  String? validateNama(String? v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null;
  String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v.trim()) ? null : 'Format email tidak valid';
  }

  @override
  void onClose() {
    nimC.dispose(); namaC.dispose(); emailC.dispose();
    super.onClose();
  }
}