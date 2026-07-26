# Easy Paint v1.0.0

**Initial public release** of Easy Paint — a simple, distraction-free native macOS painting app for children.

## What's included

- **Tools:** brush, eraser, fill bucket, straight line, rectangle, and circle
- **Colors:** eleven swatches (red, orange, yellow, green, blue, purple, pink, brown, gray, white, black)
- **Brush size:** adjustable slider from fine lines to thick strokes
- **Undo and redo** for recent canvas changes
- **PNG export** via Save
- **Child-lock fullscreen** so kids stay focused (window close/minimize/zoom controls hidden)
- **Parent exit:** quit with **⌃⌥⌘Q** (Control + Option + Command + Q)

## Download

Attach / download: **`Easy-Paint-v1.0.0-macOS.zip`**

Unzip and open **Easy Paint.app**. Optionally move it to Applications.

## System requirements

- **macOS 12.0** (Monterey) or later
- **Apple Silicon (`arm64`)** only — this binary is not a universal build and does not include Intel (`x86_64`) support

## Signing & Gatekeeper

This build is **ad-hoc signed only**. It is **not** signed with an Apple Developer ID and is **not notarized**.

On first launch, macOS Gatekeeper may block the app. To open it:

1. **System Settings → Privacy & Security** → **Open Anyway**, or
2. Right-click **Easy Paint.app** → **Open** → **Open**

You only need to approve this once.

## Privacy

Easy Paint runs locally on your Mac. It does not upload drawings or other user data. Save writes a PNG file you choose on your computer.

## Checksums

**SHA-256** of `Easy-Paint-v1.0.0-macOS.zip`:

```
e2029987a24158ab942affaf5e4c477b8fbd3f6ecb5441a19135ddb8f3f85404
```
