import 'package:flutter/material.dart';
import 'punishment_screen.dart';
import 'global_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AbsenDetailScreen extends StatefulWidget {
  final String prayerName;

  const AbsenDetailScreen({super.key, required this.prayerName});

  @override
  State<AbsenDetailScreen> createState() => _AbsenDetailScreenState();
}

class _AbsenDetailScreenState extends State<AbsenDetailScreen>
    with SingleTickerProviderStateMixin {
  Map<int, String> attendanceStatus = {};
  late AnimationController _controller;

  final int studentsPerPrayer = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildStatusButton(int index, String status, IconData icon, Color color) {
    final current = attendanceStatus[index];
    final isSelected = current == status;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              attendanceStatus[index] = status;
            });
          },
          icon: Icon(icon, size: 16),
          label: FittedBox(child: Text(status)),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? color : Colors.white,
            foregroundColor: isSelected ? Colors.white : color,
            side: BorderSide(color: color),
            elevation: isSelected ? 3 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> savePunishmentData() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = jsonEncode(
      punishmentHistory.map((entry) => {
        'date': entry['date'].toIso8601String(),
        'data': entry['data'],
      }).toList(),
    );
    await prefs.setString('punishment_history', historyJson);
  }

  void saveData() async {
    List<Map<String, dynamic>> punishmentData = [];

    attendanceStatus.forEach((index, value) {
      if (value == 'Tidak Hadir') {
        punishmentData.add({
          'nama': 'Siswa ${index + 1}',
          'jumlah': 1,
          'durasi': 2,
        });
      }
    });

    punishmentHistory.add({
      'date': DateTime.now(),
      'data': punishmentData,
    });

    await savePunishmentData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PunishmentScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Absensi ${widget.prayerName}'), backgroundColor: Colors.teal),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                RotationTransition(
                  turns: Tween(begin: -0.05, end: 0.05).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    radius: 28,
                    child: Icon(Icons.mosque, color: Colors.teal, size: 32),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Siswa - ${widget.prayerName}',
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: studentsPerPrayer,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Siswa ${index + 1}',
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          buildStatusButton(
                              index, 'Hadir', Icons.check_circle, Colors.green),
                          buildStatusButton(index, 'Tidak Hadir', Icons.cancel,
                              Colors.red),
                          buildStatusButton(
                              index, 'Izin', Icons.mail, Colors.orange),
                          buildStatusButton(
                              index, 'Sakit', Icons.healing, Colors.purple),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: saveData,
                icon: const Icon(Icons.save),
                label: const Text('Simpan & Update Punishment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}