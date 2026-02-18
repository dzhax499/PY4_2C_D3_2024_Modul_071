import 'package:flutter/material.dart';
import 'package:logbook_app_071/features/auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _step = 1;

  void _nextStep() {
    if (_step < 3) {
      setState(() {
        _step++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Onboarding")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar Onboarding
              Expanded(
                flex: 3,
                child: Image.asset(
                  "assets/images/onboarding_$_step.png",
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              // Judul dan Deskripsi (Homework)
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      _getTitle(_step),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getDescription(_step),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Page Indicator (Homework)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _step == index + 1 ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _step == index + 1 ? Colors.indigo : Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              // Tombol Navigasi
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _step < 3 ? "Lanjut" : "Mulai Sekarang",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle(int step) {
    switch (step) {
      case 1:
        return "Selamat Datang";
      case 2:
        return "Catat Kemajuanmu";
      case 3:
        return "Pantau Performamu";
      default:
        return "";
    }
  }

  String _getDescription(int step) {
    switch (step) {
      case 1:
        return "Aplikasi Logbook membantu Anda mencatat setiap aktivitas harian dengan mudah dan cepat.";
      case 2:
        return "Setiap langkah kecil berarti. Simpan progresmu agar tidak pernah kehilangan jejak.";
      case 3:
        return "Analisis riwayat aktivitasmu dan tingkatkan produktivitas setiap hari.";
      default:
        return "";
    }
  }
}
