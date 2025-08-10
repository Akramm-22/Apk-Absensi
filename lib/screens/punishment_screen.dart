import 'package:flutter/material.dart';
import 'global_data.dart';

class PunishmentScreen extends StatefulWidget {
  const PunishmentScreen({super.key});

  @override
  State<PunishmentScreen> createState() => _PunishmentScreenState();
}

class _PunishmentScreenState extends State<PunishmentScreen> {
  void deleteSiswa(String key, int index) {
    setState(() {
      groupedData[key]!.removeAt(index);
      if (groupedData[key]!.isEmpty) {
        groupedData.remove(key);
      }
      savePunishmentData(); // Simpan kembali jika pakai penyimpanan lokal
    });
  }

  // Group data berdasarkan "date + waktu"
  Map<String, List<Map<String, dynamic>>> get groupedData {
    final Map<String, List<Map<String, dynamic>>> map = {};

    for (var history in punishmentHistory) {
      final date = history['date'] as DateTime;
      final data = history['data'] as List<Map<String, dynamic>>;

      for (var siswa in data) {
        final waktu = siswa['waktu'] ?? 'Tidak diketahui';
        final key = '${date.toIso8601String()}-$waktu';

        if (!map.containsKey(key)) {
          map[key] = [];
        }

        map[key]!.add(siswa..['tanggal'] = date);
      }
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    final entries = groupedData.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Punishment'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final key = entries[index].key;
          final siswaList = entries[index].value;
          final tanggal = siswaList.first['tanggal'] as DateTime;
          final waktu = siswaList.first['waktu'] ?? 'Tidak diketahui';

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_formatDate(tanggal)} ($waktu)',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Divider(),
                  ...List.generate(siswaList.length, (i) {
                    final siswa = siswaList[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  siswa['nama'] ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Pelanggaran: ${siswa['jumlah']}x'),
                                Text('HP dibanned: ${siswa['durasi']} jam'),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteSiswa(key, i),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final List<String> days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    final List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    final dayName = days[date.weekday - 1];
    final formattedDate = '$dayName - ${date.day} ${months[date.month - 1]} ${date.year}';
    return formattedDate;
  }
}