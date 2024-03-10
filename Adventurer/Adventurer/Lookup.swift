//
//  Lookup.swift
//  Adventurer
//
//  Created by Geoffrey Irving on 3/10/24.
//

import CoreGraphics
import SpriteKit

// Lookup colors in an image via 1x1 renders
struct Lookup {
  let image: CGImage
  
  init(_ texture: SKTexture) {
    image = texture.cgImage()
  }

  func at(_ p: CGPoint) -> SKColor {
    // Create a 1x1 context
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
    let context = CGContext(data: nil, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

    // Draw the image, shifting its origin to the desired pixel
    let w = Double(image.width), h = Double(image.height)
    context.draw(image, in: CGRect(x: -w * p.x, y: -h * p.y, width: w, height: w))

    // Extract the pixel data
    guard let pixel = context.data?.assumingMemoryBound(to: UInt8.self) else {
      return .red  // Red for errors
    }
    return UIColor(red: CGFloat(pixel[1]) / 255.0,
                   green: CGFloat(pixel[2]) / 255.0,
                   blue: CGFloat(pixel[3]) / 255.0,
                   alpha: CGFloat(pixel[0]) / 255.0)
  }
}
