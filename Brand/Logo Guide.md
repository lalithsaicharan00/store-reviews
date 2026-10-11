# Often Enough — Logo Guide

Written by Codex, 11 October 2026. The user approved the tilted tonal logo and explicitly confirmed its tone order. This root guide owns current reproduction rules (Rulebook U29); native packaging/device rendering remain separate (U9).

[Visual Figma guide](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1163-2) · [Final variations](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1160-2) · [Clean export sources](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1166-2)

## Identity and meaning

**Small actions, repeated often enough, build something lasting.**

Three rounded pieces build upward. The newer upper-right piece sits in front of the earlier pieces. The whole construction tilts 12° clockwise. Tonal progression is part of the identity; single-ink black and white versions were rejected by the user.

## Approved tonal appearances

Order is **base → middle → top**. The top stays darkest on light backgrounds and brightest on dark backgrounds.

| Appearance | Background | Base | Middle | Top |
|---|---|---|---|---|
| Light | 1.00 / `#FFFFFF` | 0.75 / `#BFBFBF` | 0.40 / `#666666` | 0.20 / `#333333` |
| Dark | 0.05 / `#0D0D0D` | 0.25 / `#404040` | 0.65 / `#A6A6A6` | 1.00 / `#FFFFFF` |

Values are equal red/green/blue floating-point Figma channels; hex values are nearest 8-bit equivalents. Preserve exact source values when editing, and use the exported files for reproduction. Do not reverse the order, mix appearances or substitute single ink. Transparent marks belong on simple matching surfaces; busy backgrounds need a suitable solid field behind the icon.

## Proportional sizing

The square master is 1024 × 1024. Its centered nested artwork frame is **52:60 = 86.6667%** of the canvas, or 887.4667 pixels at master size. This frame includes transparent padding; **52 pixels is not a tight visible-glyph width**. Scale the complete artwork, tilt, seams and padding together.

| Square canvas | Inner artwork frame |
|---|---|
| 1024 px | 887.4667 px |
| 120 px | 104 px |
| 60 px | 52 px |
| 48 px | 41.60 px |
| 40 px | 34.6667 px |
| 32 px | 27.7333 px |
| 24 px | 20.80 px |

Solid flat fills and true transparent seams carry the depth. Do not add heavy shadows, outlines, gradients, textures or thick dimensional edges. Do not stretch, mirror, close gaps or rotate tiles individually.

## Clear space and minimum size

These are reasoned usage recommendations, not additional user-selected geometry or platform requirements:

- Leave at least one quarter of a tile side beyond the visible outline for standalone use: 91 units at the 1024-canvas scale. Allow more space where possible.
- Prefer at least 48 pixels for a standalone brand mark and 24 pixels for compact app-icon use.
- Treat 16/20-pixel examples as stress checks. Smaller native contexts need device review; no single-ink substitute is approved.

The final board has 72 actual-size examples: two appearances × four masks × nine sizes (120/60/48/40/32/29/24/20/16), plus four enlarged previews. The visual guide adds 16 examples at 60/48/32/24 under iOS and circular masks. Fine tonal detail becomes small in the stress checks.

## Current source assets

| Asset | Current Figma node | Delivered files |
|---|---|---|
| Light app master | `1166:7` | 1024 PNG and derived smaller PNGs |
| Dark app master | `1166:38` | 1024 PNG and derived smaller PNGs |
| Transparent light tonal mark | `1166:17` | SVG and 1024 PNG |
| Transparent dark tonal mark | `1166:48` | SVG and 1024 PNG |
| Android light foreground / background | `1166:27` / `1166:37` | Foreground SVG/PNG, background PNG; all 1536 square |
| Android dark foreground / background | `1166:58` / `1166:68` | Foreground SVG/PNG, background PNG; all 1536 square |
| Light / dark listing | Derived from `1166:7` / `1166:38` | 512 PNG |

See the [Asset Guide](<Assets/README.md>) for files/sizes and the [manifest](<Assets/manifest.json>) for direct/derived provenance, dimensions, alpha and SHA-256 checksums. Smaller PNGs are proportionally resampled from direct 1024 exports, not optical redraws. SVGs preserve scalable contours; reuse the PNG when exact rendered appearance is required.

## Exact construction and source recovery

At 1024 canvas scale, the unrotated mark spans 624 × 624. Each tile is 364 × 364, with equal 130-pixel horizontal/upward steps. Corners have radius 101.92 (28% of 364), with 0.6 smoothing in Figma. The genuine transparent overlap separation is 27.7333 pixels. Preserve the complete exported artwork rather than rebuilding lower pieces from three plain rectangles: their occluded contours already incorporate those seams.

The Figma rotation getter is −12°; the appearance is 12° clockwise in screen coordinates. The inner frame's transparent padding rotates with the complete construction. Do not resize from a tight visible bounding box or snap each piece independently.

The earlier source board was removed during file cleanup. New board `1166:2` clones the surviving unmasked artwork in the approved review board. Its paints and 52:60 frame/12° transform were checked; current source IDs above replace historical export-board references.

## Platform layers and masks

The app masters are square, opaque and unmasked. Rounded iOS, circular Android and rounded-square outlines in preview sheets are demonstrations; use square source files for platform packaging. The rounded-square Android/Play preview uses a representative 30% corner radius; Android launcher masks vary.

Android foreground/background references each use 1536 × 1536 pixels to represent a 108-dp layer. The central 72-dp viewport is 1024 pixels, offset by 256 pixels (18 dp) on each edge. The foreground preserves the exact approved app-canvas scale in that viewport and is transparent elsewhere. The final unrotated 624-pixel construction maps to 43.875 dp, below the published suggested 48–66-dp range recorded during exploration. This deliberately preserves the user's smaller composition; validate its size and motion on target launchers during integration. The reconstructed 66-dp circle in the guide is a conservative fit check, not an imported official template.

The 512-pixel Google Play listing PNG is a separate square asset derived from the app master, with a filled background and no baked outside shadow. It is not an adaptive foreground.

## Decision references

[Decision History](<Decision History.md>) explains the complete route and links the user's five requested milestones. Exact generation prompts and earlier color/shadow settings remain in the [exploration archive](<../Research/Research Reports/Home Screen and Visual Design/App Logo Exploration/README.md>). Only this root guide governs current reproduction.

## Validation and implementation scope

The visual guide and preview sheets were inspected after export. The Figma guide contains editable text/shapes, 55 SF Pro Semibold text nodes and no raster-filled nodes. The active final package excludes single-ink marks and the monochrome Android foreground. Actual PNG files decode at their documented dimensions: app/listing/background sources are opaque; tonal marks and foregrounds have transparent backgrounds. SVG canvas sizes, XML, three drawing shapes and tone fills are checked in the manifest.

Native asset-catalog installation, Icon Composer lighting/tinted/clear appearances, Android launcher integration and actual device acceptance remain separate (U9). Automatic single-color tinting is not approved brand artwork; resolve its implementation without silently reintroducing rejected marks. Static Figma/file checks do not claim native acceptance or measured memorability.
