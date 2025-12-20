import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

// Conditional import for web
import 'dart:html' as html if (dart.library.io) 'clipboard_helper_stub.dart';

Future<bool> copyToClipboard(String text) async {
  try {
    if (kIsWeb) {
      // Use execCommand method which works reliably in web browsers
      final textArea = html.TextAreaElement();
      textArea.value = text;
      textArea.style.position = 'fixed';
      textArea.style.top = '-9999px';
      textArea.style.left = '-9999px';
      html.document.body!.append(textArea);
      textArea.select();
      final success = html.document.execCommand('copy');
      textArea.remove();
      if (success) {
        return true;
      }
      // Fallback to Clipboard API
      try {
        await Clipboard.setData(ClipboardData(text: text));
        return true;
      } catch (_) {
        return false;
      }
    } else {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    }
  } catch (e) {
    // Final fallback
    try {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } catch (_) {
      return false;
    }
  }
}

