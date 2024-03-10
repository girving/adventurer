//
//  CGPoint.swift
//  Adventurer
//
//  Created by Geoffrey Irving on 3/10/24.
//

import CoreGraphics

extension CGPoint {
  static func -(a: CGPoint, b: CGPoint) -> CGSize {
    return CGSize(width: a.x - b.x, height: a.y - b.y)
  }

  static func +(a: CGPoint, b: CGSize) -> CGPoint {
    return CGPoint(x: a.x + b.width, y: a.y + b.height)
  }

  static func -(a: CGPoint, b: CGSize) -> CGPoint {
    return CGPoint(x: a.x - b.width, y: a.y - b.height)
  }
}
