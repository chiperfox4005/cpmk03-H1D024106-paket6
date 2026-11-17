import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/peserta_controller.dart';

class PesertaFormView extends GetView<PesertaController> {
  const PesertaFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isEdit ? 'Edit Peserta' : 'Tambah Peserta'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card.filled(
              color: colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data Peserta', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.nimC, 
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))], // HURUF & ANGKA
                      validator: controller.validateNim, 
                      enabled: !controller.isEdit,
                      decoration: const InputDecoration(
                        labelText: 'NIM',
                        hintText: 'Contoh: H1D024106',
                        prefixIcon: Icon(Icons.badge), 
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.namaC, 
                      textCapitalization: TextCapitalization.words,
                      validator: controller.validateNama,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap', 
                        prefixIcon: Icon(Icons.person), 
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.emailC, 
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email', 
                        prefixIcon: Icon(Icons.email), 
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(() => DropdownButtonFormField<String>(
                      initialValue: controller.prodiC.value,
                      items: controller.daftarProdi
                          .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                          .toList(),
                      onChanged: (v) { 
                        if (v != null) controller.prodiC.value = v; 
                      },
                      decoration: const InputDecoration(
                        labelText: 'Program Studi', 
                        prefixIcon: Icon(Icons.school), 
                        border: OutlineInputBorder(),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: controller.save, 
              icon: const Icon(Icons.save),
              label: Text(controller.isEdit ? 'Perbarui Data' : 'Simpan Data'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
                }
}