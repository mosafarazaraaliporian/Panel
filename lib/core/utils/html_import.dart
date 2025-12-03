// Conditional import wrapper for dart:html
// This file conditionally imports dart:html for web or html_stub for other platforms
library html_import;

// For web: import dart:html (which has window as top-level variable)
// For non-web: import html_stub (which has window as top-level variable)
import 'dart:html' if (dart.library.html) 'dart:html';
import 'html_stub.dart' if (dart.library.io) 'html_stub.dart';

// Re-export window and Event
export 'dart:html' if (dart.library.html) 'dart:html' show window, Event;
export 'html_stub.dart' if (dart.library.io) 'html_stub.dart' show window, Event;
