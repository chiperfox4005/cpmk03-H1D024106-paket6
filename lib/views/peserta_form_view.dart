import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/peserta_controller.dart';

class PesertaFormView extends GetView<PesertaController> {
  const PesertaFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle), child: const Icon(Icons.arrow_back, color: Colors.white)),
          onPressed: () => Get.back(),
        ),
        title: Text(controller.isEdit ? 'Edit Peserta' : 'Daftar Peserta', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFFF5F7FA), Color(0xFFF5F7FA)], stops: [0.0, 0.2, 0.2, 1.0])),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 40),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)]), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: const Color(0xFF667EEA).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))]),
                child: Row(
                  children: [
                    Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(16)), child: Icon(controller.isEdit ? Icons.edit_note : Icons.person_add, color: Colors.white, size: 30)),
                    const SizedBox(width: 16),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(controller.isEdit ? 'Perbarui Data' : 'Pendaftaran Baru', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text('Seminar Nasional Pemrograman Mobile', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 12))])),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildFormField(controller: controller.nimC, label: 'NIM Peserta', hint: 'Contoh: H1D024106', icon: Icons.badge, enabled: !controller.isEdit, textCapitalization: TextCapitalization.characters, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))], validator: controller.validateNim),
              const SizedBox(height: 16),
              _buildFormField(controller: controller.namaC, label: 'Nama Lengkap', hint: 'Masukkan nama lengkap', icon: Icons.person, textCapitalization: TextCapitalization.words, validator: controller.validateNama),
              const SizedBox(height: 16),
              _buildFormField(controller: controller.emailC, label: 'Email', hint: 'contoh@email.com', icon: Icons.email, keyboardType: TextInputType.emailAddress, validator: controller.validateEmail),
              const SizedBox(height: 16),
              Obx(() => Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2))]),
                child: DropdownButtonFormField<String>(
                  initialValue: controller.prodiC.value,
                  items: controller.daftarProdi.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (v) { if (v != null) controller.prodiC.value = v; },
                  decoration: const InputDecoration(labelText: 'Program Studi', prefixIcon: Icon(Icons.school, color: Color(0xFF667EEA)), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide.none), filled: true, fillColor: Colors.white),
                ),
              )),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: controller.save,
                  icon: const Icon(Icons.save),
                  label: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(controller.isEdit ? 'Perbarui Data' : 'Daftarkan Peserta', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  style: FilledButton.styleFrom(backgroundColor: const Color(0xFF667EEA), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4, shadowColor: const Color(0xFF667EEA).withValues(alpha: 0.4)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({required TextEditingController controller, required String label, required String hint, required IconData icon, required String? Function(String?) validator, bool enabled = true, TextInputType? keyboardType, TextCapitalization textCapitalization = TextCapitalization.none, List<TextInputFormatter>? inputFormatters}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2))]),
      child: TextFormField(
        controller: controller, enabled: enabled, keyboardType: keyboardType, textCapitalization: textCapitalization, inputFormatters: inputFormatters, validator: validator,
        decoration: InputDecoration(labelText: label, hintText: hint, prefixIcon: Icon(icon, color: const Color(0xFF667EEA)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none), filled: true, fillColor: Colors.white),
      ),
    );
  }
}