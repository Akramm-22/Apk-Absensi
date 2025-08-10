import 'package:flutter/material.dart';
import 'table_screen.dart';
import 'punishment_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget buildTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget destination,
    Color color,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          radius: 25,
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.035,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.school, size: 64, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    'Absensi Siswa',
                    style: TextStyle(
                      fontSize: isTablet ? 28 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pantau aktivitas harian siswa dengan mudah',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isTablet ? 18 : 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Menu Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  buildTile(
                    context,
                    'Absensi Sholat 5 Waktu',
                    'Pencatatan kehadiran sholat siswa',
                    Icons.access_time,
                    const TableScreen(title: 'Absensi Sholat 5 Waktu', source: 'sholat'),
                    Colors.teal,
                  ),
                  buildTile(
                    context,
                    'Piket Pagi',
                    'Penjadwalan dan catatan piket pagi siswa',
                    Icons.wb_sunny,
                    const TableScreen(title: 'Piket Pagi', source: 'pagi'),
                    Colors.orange,
                  ),
                  buildTile(
                    context,
                    'Piket Sore',
                    'Pencatatan pelaksanaan piket sore',
                    Icons.nights_stay,
                    const TableScreen(title: 'Piket Sore', source: 'sore'),
                    Colors.purple,
                  ),
                  buildTile(
                    context,
                    'Punishment',
                    'Siswa yang melanggar aturan absensi atau piket',
                    Icons.warning_amber_rounded,
                    const PunishmentScreen(),
                    Colors.redAccent,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  const ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.blue),
                    title: Text('Tentang Aplikasi'),
                    subtitle: Text(
                      'Aplikasi ini membantu asrama memantau kehadiran dan tanggung jawab siswa secara efisien.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
