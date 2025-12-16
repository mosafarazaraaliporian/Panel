import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  
  bool _isOnline = true;
  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _init();
  }

  Future<void> _init() async {
    // Check initial connectivity status
    final result = await _connectivity.checkConnectivity();
    _isOnline = _hasInternetConnection(result);
    notifyListeners();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final wasOnline = _isOnline;
        _isOnline = _hasInternetConnection(results);
        
        if (wasOnline != _isOnline) {
          notifyListeners();
        }
      },
    );
  }

  bool _hasInternetConnection(List<ConnectivityResult> results) {
    // If any result shows connectivity, we're online
    return results.any((result) => 
      result != ConnectivityResult.none
    );
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}

