# Changelog

## [1.0.0] - 2026-08-28

`kn_vehicle_warning` 1.0.1 と `kn_weapon_warning` 1.1.1 を統合した初回リリース。

### Added
- 車両警告と武器警告を `Config.Vehicle` / `Config.Weapon` の 2 ブロックに統合。
- 各モジュールに `enabled` フラグを追加。`false` のときはスレッドを起動しない。
- 武器警告に `onResourceStop` のハンドラを追加。リソース停止時に NUI の表示が
  画面へ残らないようにした。
- `LICENSE`（MIT）。

### Fixed
- **車両ハッシュ表の構築が別スレッドだったため、照合ループが空の表を参照しうる
  競合状態があったのを修正。** 同一ファイル内で先に構築するようにした。

### Changed
- 車両警告の表示位置を `Config.Vehicle.position` で変更できるようにした
  （旧実装は `DrawText(0.01, 0.01)` の直書き）。

### Removed
- `kn_weapon_warning` の `Config.Display`（x / y / scale / font / textColor /
  bgColor / bgPadding）を削除。**旧実装のコード側から一度も参照されていなかった**
  設定で、実際の見た目は `html/index.html` の CSS が決めていた。
- `escrow_ignore`（有償販売ではなく MIT での公開に切り替えたため）。

### 移行時の注意
- 旧 `kn_vehicle_warning` / `kn_weapon_warning` を**削除してから**導入すること。
  同時に起動すると警告が二重に表示される。
