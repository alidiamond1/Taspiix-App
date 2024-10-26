import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'taxbiix_logic.dart';
import 'taxbiix_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaxbiixLogic(),
      child: MaterialApp(
        title: 'Taxbiix App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const TaxbiixScreen(),
      ),
    );
  }
}
