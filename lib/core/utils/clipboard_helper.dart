import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'clipboard_helper_web.dart' if (dart.library.io) 'clipboard_helper_stub.dart' as clipboard_web;

Future<bool> copyToClipboard(String text) async {
  try {
    if (kIsWeb) {
      return await clipboard_web.copyToClipboardWeb(text);
    } else {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    }
  } catch (e) {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } catch (_) {
      return false;
    }
  }
}

