import 'package:flutter/material.dart';
import 'package:beuber/services/auth_service.dart'; // To‘g‘ri yo‘l

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

  Future<void> _login() async {
    final success = await AuthService.loginUser(
      emailController.text,
      passwordController.text,
    );

    setState(() {
      message = success ? 'Kirish muvaffaqiyatli' : 'Email yoki parol xato';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kirish')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Parol'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text('Kirish')),
            if (message.isNotEmpty) Text(message),
          ],
        ),
      ),
    );
  }
}
