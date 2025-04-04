import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'home_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Permission.storage.request();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M.A.S.S.',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          datePickerTheme: const DatePickerThemeData(
            dividerColor: Colors.blue,
          )).copyWith(
          colorScheme: const ColorScheme.light(
        primary: Colors.blue,
      )),
      home: const MyHomePage(title: 'M.A.S.S.'),
      debugShowCheckedModeBanner: false,
    );
  }
}
