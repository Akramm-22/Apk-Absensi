import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:baru/screens/global_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadPunishmentData(); // penting agar data punishment ter-load saat awal
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Absensi Siswa',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}
