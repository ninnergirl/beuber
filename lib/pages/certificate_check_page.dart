// === FAYL: lib/pages/certificate_check_page.dart ===

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';

class CertificateCheckPage extends StatefulWidget {
  const CertificateCheckPage({super.key});

  @override
  State<CertificateCheckPage> createState() => _CertificateCheckPageState();
}

class _CertificateCheckPageState extends State<CertificateCheckPage> {
  File? selectedFile;
  String result = '';
  bool isLoading = false;

  Future<void> pickFileAndCheck() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );
    if (picked != null && picked.files.single.path != null) {
      setState(() {
        selectedFile = File(picked.files.single.path!);
        isLoading = true;
        result = '';
      });

      await Future.delayed(
        const Duration(seconds: 2),
      ); // Keyinchalik AI tekshiruv API qo‘shiladi

      // Mock tekshiruv logikasi
      final fileName =
          selectedFile!.path.split(Platform.pathSeparator).last.toLowerCase();
      final mimeType = lookupMimeType(selectedFile!.path);
      print("Fayl MIME turi: $mimeType");

      if (fileName.contains("fake") || fileName.contains("soxta")) {
        result = '❌ Soxta hujjat aniqlandi';
      } else if (fileName.contains("ielts") ||
          fileName.contains("diploma") ||
          fileName.contains("cert")) {
        result =
            '✅ Hujjat haqiqiyga o‘xshaydi (AI tomonidan tasdiqlanishi kerak)';
      } else {
        result =
            'ℹ️ Hujjat tanib bo‘lmadi. Iltimos, rasmiy nomlar bilan yuklang.';
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Sertifikat Tekshiruv')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedFile != null)
              Text(
                'Yuklangan fayl: ${selectedFile!.path.split(Platform.pathSeparator).last}',
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: pickFileAndCheck,
              icon: const Icon(Icons.file_present),
              label: const Text('Hujjatni tanlash va tekshirish'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 30),
            if (isLoading) const CircularProgressIndicator(),
            if (result.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  result,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
