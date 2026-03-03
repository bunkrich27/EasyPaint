# 🎨 Easy Paint

A simple, distraction-free painting app for kids — built as a native macOS app with a WebKit canvas.

## Features

- **7 vibrant colours** — red, orange, yellow, green, blue, purple, and black
- **Adjustable brush size** — smooth slider from fine lines to thick strokes
- **Eraser** — toggle on/off to fix mistakes
- **Undo & Clear** — step back or start fresh with one click
- **Child-lock fullscreen** — launches straight into fullscreen with the close, minimise, and zoom buttons hidden so little ones stay focused
- **Parent exit** — quit with `⌃⌥⌘Q` when it's time to stop

## Requirements

- macOS 12.0+
- Xcode Command Line Tools (`xcode-select --install`)

## Build

```bash
bash build_app.sh
```

This compiles the Swift source, generates the app icon, bundles everything into **`dist/Easy Paint.app`**, and creates a distributable **`dist/Easy Paint.zip`**.

## Run

```bash
open "dist/Easy Paint.app"
```

## Project Structure

```
EasyPaint/
├── Sources/EasyPaint/main.swift   # Native app shell (Cocoa + WebKit)
├── index.html                     # Paint UI (HTML Canvas)
├── scripts/generate_icon.swift    # Programmatic icon generator
├── build_app.sh                   # Build & bundle script
└── dist/                          # Build output (gitignored)
```

## License

MIT
