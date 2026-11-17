import 'package:get/get.dart';
import '../controllers/peserta_controller.dart';

class PesertaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesertaController>(() => PesertaController());
  }
}