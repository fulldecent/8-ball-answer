import AppKit
import CoreGraphics
import Foundation

let owner = "8 Ball"
let canvasWidth: CGFloat = 1440
let canvasHeight: CGFloat = 900

func windowID() -> UInt32? {
    let info = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [[String: Any]] ?? []
    for window in info {
        let name = window[kCGWindowOwnerName as String] as? String
        let layer = window[kCGWindowLayer as String] as? Int
        guard name == owner, layer == 0 else { continue }
        let bounds = window[kCGWindowBounds as String] as? [String: Any] ?? [:]
        let width = (bounds["Width"] as? NSNumber)?.doubleValue ?? 0
        let height = (bounds["Height"] as? NSNumber)?.doubleValue ?? 0
        guard width >= 50, height >= 50 else { continue }
        if let number = window[kCGWindowNumber as String] as? NSNumber {
            return number.uint32Value
        }
    }
    return nil
}

guard CommandLine.arguments.count == 2 else {
    fputs("usage: mac_screenshot <destination.png>\n", stderr)
    exit(2)
}

let destination = CommandLine.arguments[1]
var found: UInt32?
for _ in 0..<20 {
    if let id = windowID() {
        found = id
        break
    }
    Thread.sleep(forTimeInterval: 0.5)
}
guard let found else {
    fputs("8 Ball window was not on screen\n", stderr)
    exit(1)
}

let raw = destination + ".window.png"
let capture = Process()
capture.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
capture.arguments = ["-l", String(found), "-o", "-x", raw]
try capture.run()
capture.waitUntilExit()
if capture.terminationStatus != 0 {
    fputs("screencapture failed\n", stderr)
    exit(capture.terminationStatus)
}

guard let source = NSImage(contentsOfFile: raw), source.size.width >= 10, source.size.height >= 10 else {
    fputs("screenshot was empty\n", stderr)
    exit(1)
}

let canvas = NSImage(size: NSSize(width: canvasWidth, height: canvasHeight))
canvas.lockFocus()
NSColor.black.set()
NSRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight).fill()
let scale = min(canvasWidth / source.size.width, canvasHeight / source.size.height)
let drawnWidth = source.size.width * scale
let drawnHeight = source.size.height * scale
let rect = NSRect(
    x: (canvasWidth - drawnWidth) / 2,
    y: (canvasHeight - drawnHeight) / 2,
    width: drawnWidth,
    height: drawnHeight
)
source.draw(in: rect, from: NSRect(origin: .zero, size: source.size), operation: .sourceOver, fraction: 1)
canvas.unlockFocus()

guard
    let tiff = canvas.tiffRepresentation,
    let rep = NSBitmapImageRep(data: tiff),
    let png = rep.representation(using: .png, properties: [:])
else {
    fputs("could not encode screenshot\n", stderr)
    exit(1)
}

do {
    try png.write(to: URL(fileURLWithPath: destination))
} catch {
    fputs("could not write screenshot\n", stderr)
    exit(1)
}
try? FileManager.default.removeItem(atPath: raw)
