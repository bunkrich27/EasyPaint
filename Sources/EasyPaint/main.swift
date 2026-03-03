import Cocoa
import WebKit

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
  private var window: NSWindow?
  private let childLockEnabled = true

  func applicationDidFinishLaunching(_ notification: Notification) {
    setupMenu()
    buildWindow()
    NSApp.activate(ignoringOtherApps: true)
  }

  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    true
  }

  private func setupMenu() {
    let mainMenu = NSMenu()

    let appMenuItem = NSMenuItem()
    mainMenu.addItem(appMenuItem)

    let appMenu = NSMenu()
    let appName = ProcessInfo.processInfo.processName
    appMenu.addItem(withTitle: "About \(appName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "")
    appMenu.addItem(NSMenuItem.separator())
    if childLockEnabled {
      let parentExit = NSMenuItem(title: "Parent Exit", action: #selector(parentExit), keyEquivalent: "q")
      parentExit.keyEquivalentModifierMask = [.control, .option, .command]
      appMenu.addItem(parentExit)
    } else {
      appMenu.addItem(withTitle: "Quit \(appName)", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
    }
    appMenuItem.submenu = appMenu

    NSApp.mainMenu = mainMenu
  }

  @objc private func parentExit() {
    NSApplication.shared.terminate(nil)
  }

  private func buildWindow() {
    let window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 1240, height: 840),
      styleMask: [.titled, .resizable, .fullSizeContentView],
      backing: .buffered,
      defer: false
    )
    window.title = "Easy Paint"
    window.center()
    window.minSize = NSSize(width: 720, height: 520)
    window.collectionBehavior = [.fullScreenPrimary]
    window.delegate = self
    window.standardWindowButton(.closeButton)?.isHidden = childLockEnabled
    window.standardWindowButton(.miniaturizeButton)?.isHidden = childLockEnabled
    window.standardWindowButton(.zoomButton)?.isHidden = childLockEnabled

    let webViewConfig = WKWebViewConfiguration()
    webViewConfig.preferences.isTextInteractionEnabled = false

    let webView = WKWebView(frame: window.contentView?.bounds ?? .zero, configuration: webViewConfig)
    webView.autoresizingMask = [.width, .height]

    if let htmlURL = Bundle.main.url(forResource: "index", withExtension: "html") {
      webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL.deletingLastPathComponent())
    } else {
      let fallback = """
      <html><body style="font-family:-apple-system;padding:20px">
      <h2>Easy Paint</h2>
      <p>Could not load index.html from app resources.</p>
      </body></html>
      """
      webView.loadHTMLString(fallback, baseURL: nil)
    }

    window.contentView = webView
    window.makeKeyAndOrderFront(nil)
    self.window = window
    enforceFullscreen(after: 0.15)
  }

  private func enforceFullscreen(after delay: TimeInterval = 0.0) {
    guard childLockEnabled, let window else {
      return
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      guard !window.styleMask.contains(.fullScreen) else {
        return
      }
      window.toggleFullScreen(nil)
    }
  }

  func windowShouldClose(_ sender: NSWindow) -> Bool {
    !childLockEnabled
  }

  func windowDidExitFullScreen(_ notification: Notification) {
    enforceFullscreen(after: 0.1)
  }

  func window(
    _ window: NSWindow,
    willUseFullScreenPresentationOptions proposedOptions: NSApplication.PresentationOptions
  ) -> NSApplication.PresentationOptions {
    if childLockEnabled {
      return [.fullScreen, .autoHideDock, .autoHideMenuBar]
    }
    return proposedOptions
  }
}

@main
struct EasyPaintApp {
  static func main() {
    let app = NSApplication.shared
    app.setActivationPolicy(.regular)
    let delegate = AppDelegate()
    app.delegate = delegate
    app.run()
  }
}
