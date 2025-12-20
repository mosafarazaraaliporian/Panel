import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

// Conditional import for web
import 'clipboard_helper_web.dart' if (dart.library.io) 'clipboard_helper_stub.dart' as clipboard_web;

Future<bool> copyToClipboard(String text) async {
  try {
    if (kIsWeb) {
      // Use web-specific implementation
      return await clipboard_web.copyToClipboardWeb(text);
    } else {
      // Use standard Clipboard API for mobile/desktop
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    }
  } catch (e) {
    // Fallback
    try {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } catch (_) {
      return false;
    }
  }
}

