# kn_warnings

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](CHANGELOG.md)
[![Framework](https://img.shields.io/badge/framework-Standalone-green.svg)](#requirements)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)

On-screen warning overlays for restricted **vehicles** and **weapons**.
Standalone — no framework required.

指定した**車両**および**武器**を使っている間、画面に警告テキストを表示します。
フレームワークには依存しません。

> This resource replaces `kn_vehicle_warning` and `kn_weapon_warning`.
> 本リソースは `kn_vehicle_warning` と `kn_weapon_warning` を統合したものです。
> 移行手順は [Migration](#migration--移行) を参照してください。

---

## Features / 機能

| Module | Trigger | Rendering |
|---|---|---|
| **Vehicle** | Sitting in a listed vehicle | Native `DrawText` (top-left by default) |
| **Weapon** | Holding a listed weapon | NUI overlay (`html/index.html`) |

Each module can be disabled independently. **A disabled module does not start its
thread at all** — it costs nothing.
無効にしたモジュールはスレッド自体が起動しないため、負荷はゼロです。

## Requirements

- FiveM server (`fx_version cerulean`, `lua54`)
- No dependencies, no framework, no database.

## Installation / 導入

1. Place `kn_warnings` in your `resources` folder.
2. Add `ensure kn_warnings` to `server.cfg`.
3. Edit `config.lua`.

## Configuration / 設定

### `Config.Vehicle`

| Key | Default | Description |
|---|---|---|
| `enabled` | `true` | Enable the vehicle module |
| `text` | `この車両は犯罪利用禁止です` | Message shown while in a listed vehicle |
| `textColor` | `{255, 50, 50, 255}` | `{ R, G, B, A }` |
| `textScale` | `0.5` | Text size |
| `position` | `{x = 0.01, y = 0.01}` | Screen position (0.0–1.0) |
| `vehicles` | `police`, `police2`, `ambulance`, `pbus` | Spawn names to match |

> Vehicles are matched by **exact hash**. Variants such as `police4` are *not*
> included automatically — list every model you want to cover.
> 車両は**ハッシュ完全一致**で照合します。派生車種は自動では含まれません。

### `Config.Weapon`

| Key | Default | Description |
|---|---|---|
| `enabled` | `true` | Enable the weapon module |
| `weapons` | `WEAPON_BANANA` | Table keyed by weapon hash, each with a `text` field |

```lua
Config.Weapon.weapons = {
    [`WEAPON_SMG`] = { text = 'Restricted weapon' },
}
```

The weapon overlay's appearance (colour, position, font, animation) is defined in
**`html/index.html`**, not in `config.lua`.
武器警告の見た目は `config.lua` ではなく `html/index.html` の CSS で編集します。

## Performance

| Module | Idle | Active |
|---|---|---|
| Vehicle | `Wait(1000)` poll | per-frame draw while in a listed vehicle |
| Weapon | `Wait(500)` poll | `Wait(200)` poll; drawing is done by the browser |

The vehicle module **must** draw every frame — that is how `DrawText` works in
FiveM. It only does so while the player is actually inside a listed vehicle.
車両モジュールは対象車両に乗っている間だけ毎フレーム描画します。

## Migration / 移行

Replacing the two older resources:

1. Remove `ensure kn_vehicle_warning` and `ensure kn_weapon_warning` from `server.cfg`.
2. Delete both resource folders (leaving them installed will show the warning twice).
3. Add `ensure kn_warnings`.
4. Move your settings across:

| Old | New |
|---|---|
| `kn_vehicle_warning` → `Config.WarningText` | `Config.Vehicle.text` |
| `Config.TextColor` | `Config.Vehicle.textColor` |
| `Config.TextScale` | `Config.Vehicle.textScale` |
| `Config.RestrictedVehicles` | `Config.Vehicle.vehicles` |
| `kn_weapon_warning` → `Config.Weapons` | `Config.Weapon.weapons` |
| `Config.Display` | **Removed** — it was never read by the old code |

> ⚠ **旧2本を残したまま導入すると警告が二重に表示されます。**必ず削除してください。

## License

MIT — see [LICENSE](LICENSE).
