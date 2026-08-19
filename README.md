# 皮拉提斯課程管理（Flutter Web）

以 iPad Safari 為主要平台的 local-first Flutter Web 課程管理系統。App 不連接 REST API、ASP.NET Core、SQL Server 或雲端資料庫；業務資料直接保存在目前瀏覽器的持久化 storage。

## 架構

```text
iPad Safari / Chrome / Edge
→ Flutter Web
→ Riverpod Repository
→ Drift
→ SQLite WebAssembly
→ IndexedDB / OPFS browser storage
```

- Flutter 3.44.4 / Dart 3.12.2
- Drift 2.34.3
- sqlite3 3.5.1
- Database：`pilates` / `pilates.db`
- Schema version：1
- `WasmDatabase.open` 會依瀏覽器能力選擇可靠的 IndexedDB 或 OPFS storage；App 拒絕 in-memory fallback。

Native fallback 透過 conditional import 保留，但 Web compile path 不會 import `dart:io`、`dart:ffi` 或 `NativeDatabase`。

## Web Assets

- `web/sqlite3.wasm`：取自 sqlite3.dart 官方 `sqlite3-3.5.0` release，和 sqlite3 3.x 相容。
- `web/drift_worker.js`：Drift 2.34.3 套件隨附 worker。
- `web/pilates_service_worker.js`：offline-first App Shell 與 runtime cache。
- `web/manifest.json`：Add to Home Screen 名稱、主題、standalone display 與 icons。

## 執行與驗證

```powershell
cd D:\01.program\Flutter\pilates_flutter
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter run -d chrome
flutter build web --release --no-web-resources-cdn
```

`--no-web-resources-cdn` 會把 CanvasKit 等 renderer 資源放入 Web build，避免離線啟動依賴外部 CDN。

Release 網站輸出：

```text
build/web
```

部署必須使用 HTTPS（localhost 開發環境除外），Service Worker、Cache Storage 與可靠的 browser storage 才能正常使用。

## 本機資料與備份

資料表：

- `students`
- `course_packages`
- `purchases`
- `payments`
- `lesson_records`

Foreign keys、indexes、transactions、付款與堂數驗證均由 Drift／SQLite 保留。台幣金額使用 INTEGER。

在「系統設定 → 資料管理」可：

- 下載 `pilates_backup_yyyyMMdd_HHmm.json`
- 選擇 JSON，驗證後在單一 transaction 中還原並保留 IDs
- 下載 students、purchases、payments、lesson records CSV

Web 備份不依賴 Web Share API；Safari 即使沒有 Share API 仍可下載 JSON。

清除 Safari 網站資料、使用私人瀏覽、解除網站資料或更換裝置，都可能使本機資料遺失。請定期下載備份。

## iPad 使用

將 `build/web` 部署到 HTTPS 靜態網站後，在 Safari 開啟網址，再使用：

```text
分享 → 加入主畫面
```

首次完整載入後，Service Worker 會快取 App Shell、Flutter renderer、SQLite WASM 與 Drift worker；暫時斷網時仍可重新開啟已快取頁面並操作本機資料。

## Migration

`AppDatabase.schemaVersion` 目前為 1。未來修改 schema 時應提高版本並在 `MigrationStrategy.onUpgrade` 加入資料保留 migration，不可用刪除瀏覽器資料作為升級方式。
