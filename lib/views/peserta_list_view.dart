import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/peserta_controller.dart';

class PesertaListView extends GetView<PesertaController> {
  const PesertaListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(20)),
          child: Text(controller.statistikText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        )),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFFF5F7FA), Color(0xFFF5F7FA)], stops: [0.0, 0.25, 0.25, 1.0]),
        ),
        child: Column(
          children: [
            const SizedBox(height: 110),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))]),
                child: TextField(
                  onChanged: (v) => controller.keyword.value = v,
                  decoration: const InputDecoration(hintText: 'Cari nama atau NIM peserta...', prefixIcon: Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide.none), filled: true, fillColor: Colors.white, contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [Expanded(child: _buildFilterChip('Semua', colorScheme)), const SizedBox(width: 8), Expanded(child: _buildFilterChip('Hadir', colorScheme)), const SizedBox(width: 8), Expanded(child: _buildFilterChip('Belum Hadir', colorScheme))]),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final data = controller.displayList;
                if (data.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.event_busy, size: 80, color: colorScheme.primary.withValues(alpha: 0.3)), const SizedBox(height: 16), Text('Belum ada peserta terdaftar', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 8), Text('Tekan tombol + untuk mendaftarkan peserta baru', style: TextStyle(color: Colors.grey.shade600))])),
                  );
                }
                return ListView.builder(padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100), itemCount: data.length, itemBuilder: (context, index) => _buildPesertaCard(context, data[index]));
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: controller.openAddForm, backgroundColor: const Color(0xFF667EEA), foregroundColor: Colors.white, icon: const Icon(Icons.person_add), label: const Text('Tambah Peserta', style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildPesertaCard(BuildContext context, p) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))]),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 56, height: 56, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)]), borderRadius: BorderRadius.all(Radius.circular(16))), child: Center(child: Text(p.nama.isNotEmpty ? p.nama[0].toUpperCase() : '?', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)))),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p.nama, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)), const SizedBox(height: 2), Text(p.nim, style: TextStyle(color: colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600))])),
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: p.hadir ? const Color(0xFF10B981).withValues(alpha: 0.15) : Colors.grey.shade200, borderRadius: BorderRadius.circular(20)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(p.hadir ? Icons.check_circle : Icons.schedule, size: 14, color: p.hadir ? const Color(0xFF10B981) : Colors.grey.shade600), const SizedBox(width: 4), Text(p.hadir ? 'Hadir' : 'Belum', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: p.hadir ? const Color(0xFF10B981) : Colors.grey.shade700))])),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(children: [_buildInfoItem(Icons.email, p.email, colorScheme), const SizedBox(width: 8), _buildInfoItem(Icons.school, p.prodi, colorScheme)]),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: FilledButton.tonal(onPressed: () => controller.toggleHadir(p), style: FilledButton.styleFrom(backgroundColor: p.hadir ? const Color(0xFF10B981) : const Color(0xFF667EEA), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(p.hadir ? Icons.check_circle : Icons.how_to_reg, size: 18), const SizedBox(width: 8), Text(p.hadir ? 'Sudah Hadir' : 'Tandai Hadir', style: const TextStyle(fontWeight: FontWeight.bold))]))),
                const SizedBox(width: 8),
                Container(decoration: BoxDecoration(color: const Color(0xFFFFA726).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)), child: IconButton(icon: const Icon(Icons.edit, color: Color(0xFFFFA726)), onPressed: () => controller.openEditForm(p))),
                const SizedBox(width: 8),
                Container(decoration: BoxDecoration(color: const Color(0xFFEF4444).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)), child: IconButton(icon: const Icon(Icons.delete, color: Color(0xFFEF4444)), onPressed: () => controller.confirmDelete(p))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, ColorScheme colorScheme) {
    return Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(icon, size: 14, color: colorScheme.onSurfaceVariant), const SizedBox(width: 6), Expanded(child: Text(text, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis))])));
  }

  Widget _buildFilterChip(String label, ColorScheme colorScheme) {
    return Obx(() {
      final isSelected = controller.filterStatus.value == label;
      return InkWell(
        onTap: () => controller.setFilter(label),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? const Color(0xFF667EEA) : Colors.white.withValues(alpha: 0.5), width: 1.5)),
          child: Center(child: Text(label, style: TextStyle(color: isSelected ? const Color(0xFF667EEA) : Colors.white, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, fontSize: 13))),
        ),
      );
    });
  }
}