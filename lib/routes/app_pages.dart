import 'package:get/get.dart';
import '../bindings/peserta_binding.dart';
import '../views/home_view.dart';
import '../views/peserta_form_view.dart';
import '../views/peserta_list_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(), 
      binding: PesertaBinding(),
    ),
    GetPage(
      name: AppRoutes.peserta,
      page: () => const PesertaListView(),
    ),
    GetPage(
      name:AppRoutes.form,
      page: () => const PesertaFormView(),
    ),
  ];
}