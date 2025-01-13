import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;

  // ===============================================================================
  //       MARK: Getter
  // ===============================================================================

  /// Getter for the loading state.
  bool get isLoading => _isLoading;

  // ===============================================================================
  //       MARK: Setter
  // ===============================================================================

  /// Sets the loading state and notifies listeners if the state changes.
  void setLoading(bool value) {
    if (_isLoading != value) _isLoading = value;
    notifyListeners();
  }
}
