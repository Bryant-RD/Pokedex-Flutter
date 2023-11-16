import 'package:flutter/material.dart';

class TypeSelected with ChangeNotifier {
  
  Set<String> _selectedTypes = {};

  Set<String> get selectedTypes => _selectedTypes;

    void toggleType(String type) {
    if (_selectedTypes.contains(type)) {
      _selectedTypes.remove(type);
    } else if (_selectedTypes.length < 2) {
      _selectedTypes.add(type);
    }
    print(_selectedTypes);
    notifyListeners();
  }

  late BuildContext _context;
  BuildContext get ctx => _context;

  void setCtx(BuildContext context) {
    _context = context;
  }

  

}