import 'package:flutter/material.dart';
import 'package:beuber/services/auth_service.dart'; // To‘g‘ri yo‘l

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

  Future<void> _register() async {
    final success = await AuthService.registerUser(
      emailController.text,
      passwordController.text,
    );

    setState(() {
      message =
          success ? 'Ro‘yxatdan o‘tish muvaffaqiyatli' : 'Xatolik yuz berdi';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ro'yxatdan o'tish")),
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
            ElevatedButton(
              onPressed: _register,
              child: const Text("Ro'yxatdan o'tish"),
            ),
            if (message.isNotEmpty) Text(message),
          ],
        ),
      ),
    );
  }
}
