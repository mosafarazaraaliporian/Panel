typedef JSObject = dynamic;

class JS {
  const JS(String name);
}
external JSObject? _windowOpen(String url, String target, String features);
external int get _screenWidth;
external int get _screenHeight;
external void _windowClose();
external JSObject? get _windowOpener;
external String get _windowHash;
