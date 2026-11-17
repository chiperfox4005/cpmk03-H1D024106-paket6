import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/peserta_controller.dart';

class PesertaListView extends GetView<PesertaController> {
  const PesertaListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.statistikText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: Column(
        children: [
          // 1. Search Bar Modern
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => controller.keyword.value = v,
              decoration: InputDecoration(
                hintText: 'Cari nama atau NIM...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            ),
          
          // 2. Filter Chips Modern
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip('Semua', colorScheme),
                _buildFilterChip('Hadir', colorScheme),
                _buildFilterChip('Belum Hadir', colorScheme),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // 3. Daftar Data
          Expanded(
            child: Obx(() {
              final data = controller.displayList;
              if (data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined, size: 64, color: colorScheme.onSurfaceVariant),
                      const SizedBox(height: 16),
                      Text(
                        'Belum ada data peserta',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final p = data[index];
                  return Card.filled(
                    color: colorScheme.surfaceContainerLowest,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: colorScheme.primaryContainer,
                                foregroundColor: colorScheme.onPrimaryContainer,
                                child: Text(
                                  p.nama.isNotEmpty ? p.nama[0].toUpperCase() : '?',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(p.nama, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text('NIM: ${p.nim}', style: Theme.of(context).textTheme.bodyMedium),
                                    Text('Email: ${p.email}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                                    Text('Prodi: ${p.prodi}', style: Theme.of(context).textTheme.bodySmall),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, size: 14, color: colorScheme.onSurfaceVariant),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${p.waktuDaftar.day}/${p.waktuDaftar.month}/${p.waktuDaftar.year}',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // FITUR KHUSUS: BUTTON HADIR (Bukan Checkbox)
                              FilledButton.tonal(
                                onPressed: () => controller.toggleHadir(p),
                                style: FilledButton.styleFrom(
                                  backgroundColor: p.hadir ? Colors.green.shade100 : Colors.grey.shade300,
                                  foregroundColor: p.hadir ? Colors.green.shade800 : Colors.grey.shade700,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(p.hadir ? Icons.check_circle : Icons.radio_button_unchecked, size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                      p.hadir ? 'Hadir' : 'Belum Hadir',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton.filledTonal(
                                    icon: const Icon(Icons.edit, size: 18),
                                    onPressed: () => controller.openEditForm(p),
                                    tooltip: 'Edit',
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton.filledTonal(
                                    icon: const Icon(Icons.delete, size: 18),
                                    color: Colors.red.shade700,
                                    onPressed: () => controller.confirmDelete(p),
                                    tooltip: 'Hapus',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openAddForm,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Peserta'),
      ),
    );
  }

  Widget _buildFilterChip(String label, ColorScheme colorScheme) {
    return Obx(() {
      final isSelected = controller.filterStatus.value == label;
      return ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) controller.setFilter(label);
        },
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(
          color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      );
    });
  }
}