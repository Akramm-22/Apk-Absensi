import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _index = 0;
  final List<Widget> _pages = const [
    OnboardPage(
      title: 'Absensi Lebih Mudah',
      description: 'Kini asrama bisa mencatat absensi harian dengan cepat, efisien, dan tanpa kertas.',
      image: 'assets/1.png',
    ),
    OnboardPage(
      title: 'Tersedia Jadwal Lengkap',
      description: 'Absensi Sholat 5 Waktu, piket pagi dan sore serta punishment siswa terintegrasi dalam satu aplikasi.',
      image: 'assets/2.png',
    ),
    OnboardPage(
      title: 'Monitoring Efektif',
      description: 'Guru dan pengurus dapat dengan mudah memantau kehadiran, tugas piket, dan pelanggaran siswa secara real-time.',
      image: 'assets/3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _pages[_index]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (i) => _buildDot(i)),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_index == _pages.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                );
              } else {
                setState(() => _index++);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: Text(_index == _pages.length - 1 ? 'Mulai' : 'Selanjutnya'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDot(int i) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _index == i ? 12 : 8,
      height: _index == i ? 12 : 8,
      decoration: BoxDecoration(
        color: _index == i ? Colors.teal : Colors.teal.shade200,
        shape: BoxShape.circle,
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String title, description, image;

  const OnboardPage({super.key, required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          const SizedBox(height: 30),
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}