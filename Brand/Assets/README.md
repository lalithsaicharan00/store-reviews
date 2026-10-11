# Logo Assets

Written by Codex, 11 October 2026. These files reproduce the user-finalized tilted tonal logo. Follow the [Logo Guide](<../Logo Guide.md>) for tones, inset, tilt and reproduction rules.

| Folder | Files and use |
|---|---|
| [AppIcons/Light](<AppIcons/Light/>) / [AppIcons/Dark](<AppIcons/Dark/>) | Opaque square PNGs at 1024, 180, 167, 152, 120, 87, 80, 76, 60, 58, 48, 40, 32, 29, 24, 20 and 16 pixels. 1024 is the direct Figma source; smaller sizes use proportional LANCZOS resampling. These are exported artworks, not an installed/complete Xcode asset catalog. |
| [BrandMarks](<BrandMarks/>) | Transparent light/dark tonal SVG and 1024 PNG. SVGs contain two occluded paths and one upper rounded square; transparent seams are part of the construction. |
| [Android](<Android/>) | Separate light/dark foreground SVG/PNG and opaque background PNG, all 1536 pixels for the 108-dp layer reference. Central 1024-pixel viewport corresponds to 72 dp. Native adaptive packaging remains pending. |
| [GooglePlay](<GooglePlay/>) | Light/dark opaque square 512 PNGs, derived from the app master for listing artwork. |
| [Previews](<Previews/>) | Direct Figma exports: visual guide 1448 × 3170 and final review 2496 × 2796. Masks and guides in these images are presentation evidence; do not use them as source icons. |
| [History](<History/>) | The user's exact requested milestones: Building Blocks and Rising Squares at 1024, plus a blue tonal 60-pixel sample. Historical artwork is not a current reproduction option. |

[manifest.json](<manifest.json>) inventories **51 image/vector assets**, their source Figma IDs, direct/derived provenance, dimensions, alpha and SHA-256. It excludes this README and itself. All 1024 app masters, tonal marks, Android references, review/guide and milestone images were actually downloaded from Figma; an export configuration alone is not counted as a delivered file.

For general brand use, select the transparent tonal mark matching the surface. For platform icon sources, select the square filled app PNG or the appropriate separate Android layers. Do not bake presentation masks into platform sources. No single-ink brand or monochrome Android foreground is included.
