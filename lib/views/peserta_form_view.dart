import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/peserta_controller.dart';

class PesertaFormView extends GetView<PesertaController> {
  const PesertaFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.isEdit ? 'Edit Peserta' : 'Tambah Peserta')),
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: controller.nimC, keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: controller.validateNim, enabled: !controller.isEdit,
              decoration: const InputDecoration(labelText: 'NIM (8-12 digit)', prefixIcon: Icon(Icons.badge), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.namaC, textCapitalization: TextCapitalization.words,
              validator: controller.validateNama,
              decoration: const InputDecoration(labelText: 'Nama Lengkap', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.emailC, keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.prodiC.value,
              items: controller.daftarProdi.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) { if (v != null) controller.prodiC.value = v; },
              decoration: const InputDecoration(labelText: 'Program Studi', prefixIcon: Icon(Icons.school), border: OutlineInputBorder()),
            )),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: controller.save, icon: const Icon(Icons.save),
              label: Text(controller.isEdit ? 'Perbarui' : 'Simpan'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
          ],
        ),
      ),
    );
  }
}