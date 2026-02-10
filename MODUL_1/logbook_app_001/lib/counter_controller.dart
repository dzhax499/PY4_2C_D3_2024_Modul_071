class CounterController {
  int _counter = 0; // Variabel private (Enkapsulasi)
  int _step = 1; // Variabel step dengan default value 1
  List<String> _history = []; // List untuk menyimpan riwayat aktivitas

  int get value => _counter; // Getter untuk nilai counter
  int get step => _step; // Getter untuk nilai step
  List<String> get history => _history; // Getter untuk riwayat

  // Fungsi untuk mendapatkan 5 aktivitas terakhir
  List<String> getLastFiveActivities() {
    if (_history.isEmpty) return [];
    // Ambil dari akhir list (aktivitas terakhir paling atas)
    return _history.reversed.take(5).toList().reversed.toList();
  }

  // Helper untuk mendapatkan waktu saat ini dalam format HH:mm
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  // Fungsi untuk mengubah nilai step
  void setStep(int newStep) {
    if (newStep > 0) {
      _step = newStep;
    }
  }

  // Increment menggunakan nilai step
  void increment() {
    _counter += _step;
    _history.add('User menambah nilai sebesar $_step pada jam ${_getCurrentTime()}');
  }

  // Decrement menggunakan nilai step
  void decrement() {
    if (_counter >= _step) {
      _counter -= _step;
      _history.add('User mengurangi nilai sebesar $_step pada jam ${_getCurrentTime()}');
    } else {
      _counter = 0; // Reset ke 0 jika hasil negatif
      _history.add('User mencoba decrement, nilai direset ke 0 pada jam ${_getCurrentTime()}');
    }
  }

  void reset() {
    _counter = 0;
    _history.add('User melakukan reset counter pada jam ${_getCurrentTime()}');
  }
}
