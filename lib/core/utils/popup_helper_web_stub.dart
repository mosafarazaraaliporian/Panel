// Stub file for non-web platforms
// This file provides stub implementations when dart:js_interop is not available

// Stub types - match JSObject from dart:js_interop
typedef JSObject = dynamic;

// Stub annotation class - matches the JS annotation from dart:js_interop
class JS {
  const JS(String name);
}

// Stub external functions - these match the signatures in popup_helper_web.dart
// Note: external functions don't need implementations, they're resolved at runtime
// These will never be called on non-web platforms due to kIsWeb checks in the functions
external JSObject? _windowOpen(String url, String target, String features);
external int get _screenWidth;
external int get _screenHeight;
external void _windowClose();
external JSObject? get _windowOpener;
external String get _windowHash;
