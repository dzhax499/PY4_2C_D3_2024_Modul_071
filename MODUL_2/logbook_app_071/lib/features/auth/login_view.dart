import 'package:flutter/material.dart';
// Import Controller milik sendiri (masih satu folder)
import 'package:logbook_app_071/features/auth/login_controller.dart';
// Import View dari fitur lain (Logbook) untuk navigasi
import 'package:logbook_app_071/features/logbook/counter_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _controller = LoginController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  
  // State untuk Show/Hide Password
  bool _isPasswordVisible = false;

  void _handleLogin() {
    String user = _userController.text;
    String pass = _passController.text;

    // Panggil fungsi login yang baru (return String)
    String result = _controller.login(user, pass);

    if (result == "OK") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CounterView(username: user),
        ),
      );
    } else {
      // Tampilkan Pesan Error / Kunci
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
      
      // Jika terkunci, refresh UI untuk disable tombol (opsional, tapi bagus untuk UX)
      if (_controller.isLocked) {
        setState(() {}); // Refresh UI
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Gatekeeper")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passController,
              obscureText: !_isPasswordVisible, // Gunakan state
              decoration: InputDecoration(
                labelText: "Password",
                // Ikon Mata (Show/Hide)
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // Disable tombol jika terkunci
              onPressed: _controller.isLocked ? null : _handleLogin, 
              child: Text(_controller.isLocked ? "Terkunci (Wait 10s)" : "Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}
