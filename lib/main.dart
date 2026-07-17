import 'package:flutter/material.dart';
import 'service_locator.dart';

void main() async {
  // Обов'язковий рядок, якщо ми робимо асинхронні виклики перед runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Ініціалізуємо наші сервіси
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBD Ledger',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('OBD Ledger Ready')),
      ),
    );
  }
}