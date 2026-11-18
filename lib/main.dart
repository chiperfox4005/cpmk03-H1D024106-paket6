import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/peserta_adapter.dart';
import 'models/peserta_model.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/peserta_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PesertaAdapter());
  await Hive.openBox<Peserta>(PesertaService.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Presensi Seminar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home, 
      getPages: AppPages.pages,
    );
  }
}