# Easy Paint — Small & Solid Upgrade (Approach A)

**Date:** 2026-07-14  
**Status:** Approved  
**Scope:** HTML canvas upgrade only; native Swift shell unchanged

## Goal

Make Easy Paint more useful for kids in one focused pass: smoother drawing, a few more tools, more colors, undo/redo, PNG save, and light UI polish — without complicating the child-lock macOS shell.

## Architecture

- All painting UI and logic remain in `index.html` (HTML + Canvas 2D + vanilla JS).
- `Sources/EasyPaint/main.swift` is **not** modified (fullscreen child-lock, parent exit `⌃⌥⌘Q` stay as-is).
- No new frameworks or native JS bridges.

## Features

### Tools (one active at a time)

| Tool | Behavior |
|------|----------|
| Brush | Freehand paint in selected color (default) |
| Eraser | Freehand white strokes |
| Fill | Flood-fill tapped region with current color |
| Line | Drag straight line; live preview; commit on pointer-up |
| Rect | Drag rectangle outline; live preview; commit on pointer-up |
| Circle | Drag ellipse outline; live preview; commit on pointer-up |

### Stroke quality

- Freehand uses segment interpolation (mid-points / multi-segment) so trackpad strokes look smoother.
- Round line caps and joins retained.

### Colors

- Existing: red, orange, yellow, green, blue, purple, black.
- Added: pink, brown, white, gray (11 total).
- Selecting a color exits eraser mode and applies the color to brush/fill/shapes.

### Brush size

- Slider range 2–50 (unchanged).
- Applies to brush, eraser, and shape stroke width.

### History

- Undo and redo stacks, max ~25 snapshots each.
- Snapshot before each completed freehand stroke, fill, shape, or clear.
- New drawing after undo clears the redo stack.
- Empty stack actions are no-ops.

### Save

- **Save** exports the canvas as PNG via browser download.
- Filename pattern: `easy-paint-YYYYMMDD-HHMM.png`.
- Empty (all-white) canvas still exports.

### UX polish

- Clear tool buttons with labels; large kid-friendly hit targets.
- Active tool and color highlighted.
- Trackpad hint hides after the first completed stroke.

## Edge cases

- Canvas resize preserves the painted image (existing approach).
- Flood-fill is iterative with a safety cap so large empty regions cannot hang the UI.
- Incomplete shapes cancel on pointer cancel/leave without committing history.
- Shapes commit only on pointer-up inside a completed drag.

## Out of scope

- Native macOS Save panel
- Stickers, sound effects, templates, backgrounds
- Parent gallery / multi-page storage
- Cloud sync

## Verification

1. `bash build_app.sh` succeeds.
2. App opens; draw freehand (smooth), try each tool, undo/redo, clear, save PNG.
3. Colors and brush size work.
4. Child-lock and parent exit still work (no shell changes).

## Files touched

- `index.html` — primary implementation
- `README.md` — feature list update
- This design doc under `docs/superpowers/specs/`
