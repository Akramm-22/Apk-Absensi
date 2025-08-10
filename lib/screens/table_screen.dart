import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  final String title;
  final String source;

  const TableScreen({
    super.key,
    required this.title,
    required this.source,
  });

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final List<String> siswaList = List.generate(17, (index) => 'Siswa ${index + 1}');
  final Map<String, String> kehadiranSiswa = {};

  final List<String> statusList = ['Hadir', 'Tidak Hadir', 'Izin', 'Sakit'];
  final Map<String, Color> statusColors = {
    'Hadir': Colors.green,
    'Tidak Hadir': Colors.red,
    'Izin': Colors.orange,
    'Sakit': Colors.purple,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDF8),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: siswaList.length,
              itemBuilder: (context, index) {
                final nama = siswaList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: statusList.map((status) {
                              bool isSelected = kehadiranSiswa[nama] == status;
                              return ChoiceChip(
                                label: Text(status),
                                selected: isSelected,
                                selectedColor:
                                    statusColors[status]!.withOpacity(0.2),
                                backgroundColor: Colors.transparent,
                                side: BorderSide(
                                  color: statusColors[status]!,
                                  width: 1.5,
                                ),
                                labelStyle: TextStyle(
                                  color: statusColors[status]!,
                                  fontWeight: FontWeight.bold,
                                ),
                                onSelected: (_) {
                                  setState(() {
                                    kehadiranSiswa[nama] = status;
                                  });
                                },
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: ElevatedButton.icon(
              onPressed: () {
                // Logika simpan ke database / punishment update
                // Bisa akses widget.source kalau mau simpan sesuai jenis tabel
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.save_alt_rounded, color: Colors.white),
              label: const Text(
                'Simpan & Update Punishment',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
