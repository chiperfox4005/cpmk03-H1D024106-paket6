import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/peserta_controller.dart';

class PesertaListView extends GetView<PesertaController> {
  const PesertaListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(controller.statistikText)), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => controller.keyword.value = v,
              decoration: const InputDecoration(hintText: 'Cari nama atau NIM...', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildFilterChip('Semua'), _buildFilterChip('Hadir'), _buildFilterChip('Belum Hadir'),
            ]),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final data = controller.displayList;
              if (data.isEmpty) return const Center(child: Text('Belum ada data peserta'));
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final p = data[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(p.nama.isNotEmpty ? p.nama[0].toUpperCase() : '?')),
                      title: Text(p.nama),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('NIM: ${p.nim}'), Text('Email: ${p.email}'), Text('Prodi: ${p.prodi}'),
                        Text('Daftar: ${p.waktuDaftar.day}/${p.waktuDaftar.month}/${p.waktuDaftar.year} ${p.waktuDaftar.hour}:${p.waktuDaftar.minute.toString().padLeft(2, '0')}'),
                      ]),
                      isThreeLine: true,
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        Checkbox(value: p.hadir, onChanged: (val) => controller.toggleHadir(p)),
                        IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => controller.openEditForm(p)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => controller.confirmDelete(p)),
                      ]),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: controller.openAddForm, icon: const Icon(Icons.add), label: const Text('Tambah')),
    );
  }

  Widget _buildFilterChip(String label) {
    return Obx(() => FilterChip(label: Text(label), selected: controller.filterStatus.value == label, onSelected: (selected) { if (selected) controller.setFilter(label); }));
  }
}