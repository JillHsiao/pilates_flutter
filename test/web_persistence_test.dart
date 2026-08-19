import 'web/web_persistence_stub.dart'
    if (dart.library.js_interop) 'web/web_persistence_browser.dart'
    as platform;

void main() => platform.runWebPersistenceTests();
