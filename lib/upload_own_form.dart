import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'formBuilderPackage.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class UploadAndGenerateFormPage extends StatefulWidget {
  @override
  _UploadAndGenerateFormPageState createState() =>
      _UploadAndGenerateFormPageState();
}

class _UploadAndGenerateFormPageState extends State<UploadAndGenerateFormPage> {
  List<Map<String, dynamic>> questions = [];

  String? _filePath;

  Future<void> _pickXmlFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xml'],
      );

      if (result != null) {
        if (kIsWeb) {
          // Web-specific code
          Uint8List? fileBytes = result.files.single.bytes;
          if (fileBytes != null) {
            final xmlString = String.fromCharCodes(fileBytes);
            setState(() {
              _filePath = xmlString; // Uložíme XML ako reťazec
            });
          }
        } else {
          // Mobile-specific code
          if (result != null && result.files.single.path != null) {
            setState(() {
              _filePath = result.files.single.path; // 🔹 Uloženie cesty
            });
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chyba pri nahrávaní súboru: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Vlož XML formulár',
            style: TextStyle(color: Colors.white),
          )),
      body: Column(
        children: [
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _pickXmlFile,
            child: const Text('Nahrať XML súbor'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filePath == null
                ? const Center(
                    child: Text('Nahrajte XML na zobrazenie formulára'),
                  )
                : FormBuilderPackage(xmlFilePath: _filePath!),
          ),
        ],
      ),
    );
  }
}
