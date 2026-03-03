import AppKit

let args = CommandLine.arguments
let outputPath: String = {
  if args.count > 1 {
    return args[1]
  }
  return "build/icon-1024.png"
}()

let width = 1024
let height = 1024
let canvasRect = CGRect(x: 0, y: 0, width: width, height: height)

guard let rep = NSBitmapImageRep(
  bitmapDataPlanes: nil,
  pixelsWide: width,
  pixelsHigh: height,
  bitsPerSample: 8,
  samplesPerPixel: 4,
  hasAlpha: true,
  isPlanar: false,
  colorSpaceName: .deviceRGB,
  bitmapFormat: [],
  bytesPerRow: 0,
  bitsPerPixel: 0
) else {
  fputs("Failed to create bitmap image representation.\n", stderr)
  exit(1)
}

guard let context = NSGraphicsContext(bitmapImageRep: rep) else {
  fputs("Failed to create graphics context.\n", stderr)
  exit(1)
}

func nsColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> NSColor {
  NSColor(calibratedRed: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = context

let cg = context.cgContext
cg.setAllowsAntialiasing(true)
cg.setShouldAntialias(true)

let bgPath = NSBezierPath(roundedRect: canvasRect.insetBy(dx: 30, dy: 30), xRadius: 230, yRadius: 230)
if let gradient = CGGradient(
  colorsSpace: CGColorSpaceCreateDeviceRGB(),
  colors: [
    nsColor(255, 223, 179).cgColor,
    nsColor(255, 188, 220).cgColor,
    nsColor(173, 216, 255).cgColor
  ] as CFArray,
  locations: [0.0, 0.55, 1.0]
) {
  cg.saveGState()
  cg.addPath(bgPath.cgPath)
  cg.clip()
  cg.drawLinearGradient(
    gradient,
    start: CGPoint(x: 120, y: 940),
    end: CGPoint(x: 920, y: 80),
    options: []
  )
  cg.restoreGState()
}

let sparkleColor = nsColor(255, 255, 255, 0.42)
sparkleColor.setFill()
NSBezierPath(ovalIn: CGRect(x: 130, y: 700, width: 160, height: 260)).fill()
NSBezierPath(ovalIn: CGRect(x: 760, y: 140, width: 150, height: 190)).fill()

let paletteShadow = NSBezierPath(ovalIn: CGRect(x: 172, y: 136, width: 676, height: 676))
nsColor(43, 56, 88, 0.13).setFill()
paletteShadow.fill()

let palettePath = NSBezierPath(ovalIn: CGRect(x: 160, y: 154, width: 676, height: 676))
if let paletteGradient = CGGradient(
  colorsSpace: CGColorSpaceCreateDeviceRGB(),
  colors: [
    nsColor(255, 252, 245).cgColor,
    nsColor(255, 240, 219).cgColor,
    nsColor(247, 221, 188).cgColor
  ] as CFArray,
  locations: [0.0, 0.63, 1.0]
) {
  cg.saveGState()
  cg.addPath(palettePath.cgPath)
  cg.clip()
  cg.drawLinearGradient(
    paletteGradient,
    start: CGPoint(x: 300, y: 820),
    end: CGPoint(x: 670, y: 220),
    options: []
  )
  cg.restoreGState()
}

nsColor(220, 184, 146, 0.75).setStroke()
palettePath.lineWidth = 20
palettePath.stroke()

let thumbHole = NSBezierPath(ovalIn: CGRect(x: 512, y: 280, width: 170, height: 170))
nsColor(246, 205, 164).setFill()
thumbHole.fill()
nsColor(217, 171, 126, 0.68).setStroke()
thumbHole.lineWidth = 12
thumbHole.stroke()

let paintDots: [(CGRect, NSColor)] = [
  (CGRect(x: 238, y: 594, width: 132, height: 132), nsColor(255, 106, 124)),
  (CGRect(x: 412, y: 666, width: 128, height: 128), nsColor(255, 193, 78)),
  (CGRect(x: 580, y: 592, width: 132, height: 132), nsColor(90, 199, 121)),
  (CGRect(x: 258, y: 420, width: 140, height: 140), nsColor(102, 167, 255)),
  (CGRect(x: 428, y: 390, width: 132, height: 132), nsColor(180, 124, 255))
]

for (rect, color) in paintDots {
  let dot = NSBezierPath(ovalIn: rect)
  color.setFill()
  dot.fill()
  nsColor(36, 40, 60, 0.14).setStroke()
  dot.lineWidth = 7
  dot.stroke()
}

let eyeColor = nsColor(52, 45, 61)
eyeColor.setFill()
NSBezierPath(ovalIn: CGRect(x: 322, y: 330, width: 44, height: 58)).fill()
NSBezierPath(ovalIn: CGRect(x: 444, y: 326, width: 44, height: 58)).fill()

nsColor(255, 255, 255, 0.85).setFill()
NSBezierPath(ovalIn: CGRect(x: 336, y: 359, width: 12, height: 14)).fill()
NSBezierPath(ovalIn: CGRect(x: 458, y: 355, width: 12, height: 14)).fill()

let smile = NSBezierPath()
smile.move(to: CGPoint(x: 312, y: 286))
smile.curve(
  to: CGPoint(x: 498, y: 286),
  controlPoint1: CGPoint(x: 358, y: 234),
  controlPoint2: CGPoint(x: 448, y: 232)
)
smile.lineWidth = 15
smile.lineCapStyle = .round
eyeColor.setStroke()
smile.stroke()

cg.saveGState()
cg.translateBy(x: 730, y: 318)
cg.rotate(by: -0.64)

let brushShadow = NSBezierPath(roundedRect: CGRect(x: -42, y: -144, width: 88, height: 328), xRadius: 34, yRadius: 34)
nsColor(31, 39, 58, 0.2).setFill()
brushShadow.fill()

let handle = NSBezierPath(roundedRect: CGRect(x: -34, y: -138, width: 68, height: 302), xRadius: 26, yRadius: 26)
if let handleGradient = CGGradient(
  colorsSpace: CGColorSpaceCreateDeviceRGB(),
  colors: [
    nsColor(118, 205, 252).cgColor,
    nsColor(64, 148, 235).cgColor
  ] as CFArray,
  locations: [0.0, 1.0]
) {
  cg.saveGState()
  cg.addPath(handle.cgPath)
  cg.clip()
  cg.drawLinearGradient(
    handleGradient,
    start: CGPoint(x: 0, y: 180),
    end: CGPoint(x: 0, y: -130),
    options: []
  )
  cg.restoreGState()
}

let ferrule = NSBezierPath(roundedRect: CGRect(x: -42, y: 134, width: 84, height: 82), xRadius: 20, yRadius: 20)
nsColor(244, 248, 255).setFill()
ferrule.fill()
nsColor(180, 194, 217).setStroke()
ferrule.lineWidth = 6
ferrule.stroke()

let tip = NSBezierPath()
tip.move(to: CGPoint(x: -35, y: 216))
tip.line(to: CGPoint(x: 35, y: 216))
tip.curve(to: CGPoint(x: 0, y: 304), controlPoint1: CGPoint(x: 28, y: 254), controlPoint2: CGPoint(x: 18, y: 288))
tip.curve(to: CGPoint(x: -35, y: 216), controlPoint1: CGPoint(x: -16, y: 288), controlPoint2: CGPoint(x: -30, y: 250))
tip.close()
nsColor(255, 138, 170).setFill()
tip.fill()
nsColor(201, 89, 126).setStroke()
tip.lineWidth = 5
tip.stroke()

cg.restoreGState()

NSGraphicsContext.restoreGraphicsState()

guard let pngData = rep.representation(using: .png, properties: [:]) else {
  fputs("Failed to create PNG data.\n", stderr)
  exit(1)
}

let outputURL = URL(fileURLWithPath: outputPath)
let folderURL = outputURL.deletingLastPathComponent()
do {
  try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
  try pngData.write(to: outputURL)
} catch {
  fputs("Failed to write icon file: \(error)\n", stderr)
  exit(1)
}

print(outputPath)
