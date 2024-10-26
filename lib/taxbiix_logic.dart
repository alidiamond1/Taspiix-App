import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaxbiixLogic extends ChangeNotifier {
  int _counter = 0;
  int _currentTaxbiixIndex = 0;
  bool _isVibrating = false;

  List<String> taxbiixyo = [
    'Subxaanallaah',
    'Alxamdulillaah',
    'Allaahu Akbar',
    'Laa ilaaha illallaah',
  ];

  TaxbiixLogic() {
    _loadCounter();
  }

  int get counter => _counter;
  int get currentTaxbiixIndex => _currentTaxbiixIndex;
  String get currentTaxbiix => taxbiixyo[_currentTaxbiixIndex];
  bool get isVibrating => _isVibrating;

  void incrementCounter() {
    _counter++;
    if (_counter % 33 == 0) {
      _currentTaxbiixIndex = (_currentTaxbiixIndex + 1) % taxbiixyo.length;
    }
    _saveCounter();
    notifyListeners();
  }

  void resetCounter() {
    _counter = 0;
    _currentTaxbiixIndex = 0;
    _saveCounter();
    notifyListeners();
  }

  void toggleVibration() {
    _isVibrating = !_isVibrating;
    notifyListeners();
  }

  void addTaxbiix(String newTaxbiix) {
    taxbiixyo.add(newTaxbiix);
    notifyListeners();
  }

  void removeTaxbiix(int index) {
    if (index >= 0 && index < taxbiixyo.length) {
      taxbiixyo.removeAt(index);
      if (_currentTaxbiixIndex >= taxbiixyo.length) {
        _currentTaxbiixIndex = 0;
      }
      notifyListeners();
    }
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('counter') ?? 0;
    _currentTaxbiixIndex = prefs.getInt('currentTaxbiixIndex') ?? 0;
    notifyListeners();
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
    await prefs.setInt('currentTaxbiixIndex', _currentTaxbiixIndex);
  }

  Color getBackgroundColor() {
    final List<Color> colors = [
      Colors.teal,
      Colors.blue,
      Colors.purple,
      Colors.orange,
    ];
    return colors[_currentTaxbiixIndex % colors.length];
  }
}
